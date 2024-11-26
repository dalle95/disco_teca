import 'package:firebase_auth/firebase_auth.dart';

class FirebaseGestioneErrori {
  /// Converte un [FirebaseException] in una descrizione leggibile dall'utente.
  static String descrizioneErrore(FirebaseException e) {
    switch (e.code) {
      case 'cancelled':
        return 'Operazione annullata. Riprova.';
      case 'unknown':
        return 'Si è verificato un errore sconosciuto. Contatta l\'assistenza.';
      case 'invalid-argument':
        return 'Argomento non valido fornito. Verifica i dati e riprova.';
      case 'deadline-exceeded':
        return 'Tempo scaduto per completare l\'operazione. Riprova più tardi.';
      case 'not-found':
        return 'La risorsa richiesta non è stata trovata.';
      case 'already-exists':
        return 'Il documento che stai cercando di creare esiste già.';
      case 'permission-denied':
        return 'Non hai i permessi necessari per eseguire questa operazione.';
      case 'resource-exhausted':
        return 'Risorse esaurite. Riprova più tardi.';
      case 'failed-precondition':
        return 'Operazione non valida nel contesto attuale.';
      case 'aborted':
        return 'Operazione annullata a causa di un conflitto.';
      case 'out-of-range':
        return 'Valore fornito fuori dall\'intervallo consentito.';
      case 'unimplemented':
        return 'Funzionalità non supportata.';
      case 'internal':
        return 'Errore interno del server. Riprova più tardi.';
      case 'unavailable':
        return 'Servizio momentaneamente non disponibile. Verifica la connessione e riprova.';
      case 'data-loss':
        return 'Dati persi o corrotti.';
      case 'unauthenticated':
        return 'Accesso non autorizzato. Effettua nuovamente l\'accesso.';
      default:
        return 'Errore imprevisto: ${e.message}';
    }
  }

  /// Converte un [FirebaseAuthException] in una descrizione leggibile dall'utente.
  static String descrizioneErroreAuth(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'L\'email fornita non è valida.';
      case 'user-disabled':
        return 'L\'utente è stato disabilitato. Contatta l\'assistenza.';
      case 'user-not-found':
        return 'Nessun utente trovato con questa email.';
      case 'wrong-password':
        return 'Password errata. Riprova.';
      case 'email-already-in-use':
        return 'Questa email è già associata a un altro account.';
      case 'operation-not-allowed':
        return 'Questa operazione non è consentita.';
      case 'weak-password':
        return 'La password fornita è troppo debole.';
      default:
        return 'Errore imprevisto: ${e.message}';
    }
  }
}
