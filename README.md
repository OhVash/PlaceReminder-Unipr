# MyCurrency-Unipr

Questa applicazione e' stata progettata seguendo la consegna per l'esame di Programmazione di Sistemi Mobili dell'Universita' di Parma.

Sviluppare un’applicazione per mantenere una lista di segnaposto geografici Un utente può salvare un segnaposto caratterizzato da:

- Coordinate geografiche e indirizzo ricavato tramite reverse geocoding o viceversa a partire da un indirizzo ricavando le coordinate geografiche tramite forward geocoding
- Nome ed opzionalmente una descrizione
- Data e ora di aggiunta
- I segnaposto devono essere visualizzati in una lista ordinata per data di modifica ed in una mappa
- La pressione di un marker sulla mappa deve mostrare un callout con informazioni generali e dare la possibilità di visualizzare tutti i dettagli
- I segnaposto devono poter essere eliminati dall’utente
- Quando l’utente entra nella regione (geofence) di un promemoria attivo l’app genera una notifica locale

<table>
<caption id="multi_row">Contributers summarize</caption>
<tr>    <th>Name      <th>Role               <th>Year
<tr><td>Alessandro Vascelli   <td>Author  <td>2023
</table>

## Architettura

Il programma si divide in 2 principali folder, una per le implementazioni dei vari View Controller e una per le classi Poi e Poi Manager:
1. ### Classi:

   - Poi
     Costruttore dell'oggetto Poi, necessario per salvare il segnaposto scelto dall'utente.
     
   - PoiManager
     Contiene i metodi per salvare, rimuovere o ottenere tutti i Poi memorizzati.
2. ### ViewControllers
   
   - HomeViewController
     Gestisce la vista della home page, nella quale sono presenti le textField per inserire nome, indirizzo (sia normale che in coordinate GPS), ed una descrizione opzionale, il bottone "Save"
     controlla che nome e indirizzo non siano vuoti, se tutto ok crea e salva il Poi nello sharedManager (passato poi alla lista).
     
   - ListViewController
     Metodi per la visualizzazione in una lista dei vari Poi salvati, utilizzando il metodo getAllPoi di PoiManager, viene riempita la lista; quest'utlima ordinata in base al timestamp di modifica più recente.
     Al clic su una cella apre la DetailViewController passando le info del selectedPoi.
     Al suo interno sono implementati degli observer, necessari per aggiornare la lista quando un Poi viene modificato o eliminato.
     La notifica viene lanciata dalla DetailViewController
     
   - MapViewController
     la configureMapView è impostata per una visualizzazione iniziale fissa sull'Italia intera. in più viene mostrata la posizione in tempo reale dell'utente.
     prende la lista dei Poi salvati e li aggiunge sulla mappa, i pin hanno una configurazione particolare per cui hanno il nome sopra, in modo da avere una ricerca semplificata, in più
     se vengono cliccati, si apre la loro scheda dettagli.
     
   - DetailViewController
     Vista che visualizza i dati del Poi in textField modificabili, nel caso in cui si voglia modificare il Poi direttamente senza crearne uno nuovo, è visibile anche il timestamp dell'ultima modifica.
     Metà schermo è occupato da una mapView che mostra la posizione del segnaposto.
     
     
     
     

     
