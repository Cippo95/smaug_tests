# smaug_tests

SMAUG è un software per simulare sistemi per l’accelerazione di reti neurali.  
Il repository di SMAUG si trova qui: https://github.com/harvard-acc/smaug  

Riporto qui le simulazioni fatte riguardo CNN10 una rete neurale convoluzionale costruita per il dataset CIFAR-10.  
Questo repository è solo per una condivisione più semplice delle statistiche e dei file di configurazione principali.

Per scongiurare errori di configurazione sono partito dalla configurazione fornita da SMAUG per Minerva (c'era questa e quella per LTSM, dobbiamo scrivere noi le configurazioni di altre reti):

- Ho copiato la cartella dandogli nome cnn10-smv  
- Ho cancellato i risultati delle esecuzioni precedenti (dddg..., out, outputs, stdout, stderr, dynamic_trace...)  
- Dentro la cartella ho editato il file model_files per settare il modello di rete e i parametri corretti  
- Bisogna rieseguire trace.sh (genera il tracing) e run.sh (per lanciare la simulazione) per ottenere le statistiche.  

Il file delle statistiche principali si chiama stats.txt e si trova dentro la cartella outputs.  
Per esempio il path completo al file sarà `/tests/cnn10-smv/outputs/stats.txt`.  

Il file "dynamic_trace_acc0.gz" è il file che contiene il tracing della rete.  
Non lo riporto purtroppo perché troppo grande (+200MB) per CNN10.  
GitHub si potrebbe lamentare di file più grandi di 100MB.  

SMV è un backend di ispirazione a NVDLA per accelerare le convoluzioni, le moltiplicazioni tra matrici, il pooling e la batch normalization.  

Si può attivare l'implementazione di un array sistolico per sostituire l'accelerazione delle convoluzioni di SMV (mantenendo il resto).  
Purtroppo gli sviluppatori di SMAUG non hanno implementato l'accelerazione della moltiplicazione tra matrici con l'array sistolico.  
Link a gruppo SMAUG: https://groups.google.com/g/gem5-aladdin-users/c/cIv4kd2hlXM/m/w28U3TSjBgAJ  

Riporto i passaggi per abilitare l'array sistolico:  

- Ho copiato cnn10-smv in cnn10-smv-systolic  
- Ho cancellato i risultati delle esecuzioni precedenti (dddg, out, outputs, stdout, stderr, dynamic_trace).  
- Dentro la cartella è necessario modificare trace.sh e run.sh aggiungendo "--use-systolic-array" per usare l’array sistolico.  
- È necessario inoltre aggiungere la configurazione dell’array sistolico a gem5.cfg (si copia-incolla da un’altro file presente in SMAUG "systolic_array.cfg" che non riporto).  

Le configurazioni sono un po' convolute perché riusano dei file (link simbolici) all’interno dell’immagine docker.  
Si potrebbero semplificare copiando questi file all'interno delle cartelle ma preferisco rimanere aderente a quanto fatto dagli sviluppatori di SMAUG.  
Per un corretto funzionamento bisogna quindi copiare questa cartella al path `/workspace/smaug/experiments/sims` nel volume Docker di SMAUG. 

Per copiare i file/cartelle dall'host dentro a docker bisogna usare docker cp host:sorgente container:destinazione.  
Documentazione docker cp: https://docs.docker.com/engine/reference/commandline/cp/  

Se si volessero replicare i miei risultati avverto che la compilazione di SMAUG è estremamente lunga, circa 10 ore sul mio computer con Ryzen 3500X (6 core Zen 2).
È praticamente tassativo usare l'opzione -j con il numero di core disponibili sulla propria macchina a meno di non voler aspettare un'eternità.
