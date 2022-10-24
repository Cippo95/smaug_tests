# smaug_tests

SMAUG è un software per simulare sistemi per l’accelerazione di reti neurali.
Il repository di SMAUG si trova qui: https://github.com/harvard-acc/smaug

Riporto qui le simulazioni fatte riguardo CNN10 una rete neurale convoluzionale costruita per il dataset CIFAR-10.

Per scongiurare errori di configurazione sono partito dalla configurazione fornita da SMAUG per Minerva:

- Ho copiato la cartella dandogli nome cnn10-smv
- Dentro la cartella ho editato il file "model_files" per settare i modelli corretti
- Bisogna rieseguire trace.sh (genera il tracing) e run.sh (per lanciare la simulazione) per ottenere le statistiche.

SMV è un backend di ispirazione a NVDLA per accelerare le convoluzioni, le moltiplicazioni tra matrici, il pooling e la batch normalization.

Si può attivare l'implementazione di un array sistolico per sostituire l'accelerazione delle convoluzioni di SMV (mantenendo il resto).
Purtroppo gli sviluppatori di SMAUG non hanno implementato l'accelerazione della moltiplicazione tra matrici con l'array sistolico.
Link a gruppo SMAUG: https://groups.google.com/g/gem5-aladdin-users/c/cIv4kd2hlXM/m/w28U3TSjBgAJ

Riporto i passaggi per abilitare l'array sistolico:

- Ho copiato cnn10-smv in cnn10-smv-systolic
- Dentro la cartella è necessario modificare trace.sh e run.sh aggiungendo "--use-systolic-array" per usare l’array sistolico.
- È necessario inoltre aggiungere la configurazione dell’array sistolico a gem5.cfg (si copia-incolla da un’altro file presente in SMAUG "systolic_array.cfg" che non riporto).

Le configurazioni usano degli script un po’ convoluti perché riusano alcuni file all’interno dell’immagine docker.
Si potrebbero rendere più semplici copiando i file all'interno delle cartelle ma per ora preferisco rimanere aderente a quanto fatto dagli sviluppatori di SMAUG.
Per un corretto funzionamento bisogna quindi copiare questa cartella al path "/workspace/smaug/experiments/sims" nel volume Docker di SMAUG.
Per copiare i file/cartelle bisogna usare docker cp path:sorgente path:destinazione.
Documentazione docker cp: https://docs.docker.com/engine/reference/commandline/cp/
