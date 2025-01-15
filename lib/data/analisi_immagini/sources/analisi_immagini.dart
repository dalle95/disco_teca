import 'dart:convert';
import 'package:dartz/dartz.dart';

import '/service_locator.dart';

import '/core/network/dio_client.dart';
import '/core/constants/api_url.dart';

abstract class OpenAIService {
  Future<Either<String, Map<String, dynamic>>> analyzeImageWithGPT(
      List<String> imagePaths);
}

class OpenAIServiceImpl extends OpenAIService {
  final DioClient _dioClient = sl<DioClient>();

  final String _endpoint = ApiUrl.imageAnalysis;

  @override
  Future<Either<String, Map<String, dynamic>>> analyzeImageWithGPT(
    List<String> image,
  ) async {
    if (image.isEmpty || image.length > 2) {
      return Left('È necessario fornire 1 o 2 immagini.');
    }

    try {
      // Struttura del messaggio con immagini base64
      final content = [
        {
          "type": "text",
          "text": '''
Analizza l'immagine fornita e restituisci un JSON con i seguenti campi:
- titoloAlbum: titolo album
- artista: nome artista
- anno: anno di pubblicazione
- brano1A: titolo 1° brano lato A
- brano2A: titolo 2° brano lato A
- brano3A: titolo 3° brano lato A
- brano4A: titolo 4° brano lato A
- brano5A: titolo 5° brano lato A
- brano6A: titolo 6° brano lato A
- brano7A: titolo 7° brano lato A
- brano8A: titolo 8° brano lato A
- brano1B: titolo 1° brano lato B
- brano2B: titolo 2° brano lato B
- brano3B: titolo 3° brano lato B
- brano4B: titolo 4° brano lato B
- brano5B: titolo 5° brano lato B
- brano6B: titolo 6° brano lato B
- brano7B: titolo 7° brano lato B
- brano8B: titolo 8° brano lato B
Includi nel JSON solo le chiavi per cui trovi un valore effettivo nell'immagine e ometti quelle con valori nulli o assenti.
Restituisci solo un JSON, senza altro testo o spiegazioni.
'''
        },
        ...image.map((imageBase64) => {
              "type": "image_url",
              "image_url": {"url": "data:image/jpeg;base64,$imageBase64"}
            })
      ];

      // Corpo della richiesta
      final requestBody = {
        "model": "gpt-4o-mini",
        "messages": [
          {
            "role": "user",
            "content": content,
          }
        ],
        "max_tokens": 300,
      };

      // Esegui la chiamata tramite Dio
      final response = await _dioClient.post(
        _endpoint,
        data: json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        final responseData = response.data as Map<String, dynamic>;
        return Right(responseData);
      } else {
        return Left(
            'Errore API OpenAI: ${response.statusCode} - ${response.data}');
      }
    } catch (e) {
      return Left('Errore durante la chiamata API OpenAI: $e');
    }
  }
}
