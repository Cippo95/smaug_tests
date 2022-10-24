# smaug_tests
SMAUG è un software per simulare sistemi per l’accelerazione di reti neurali.
Il repository di SMAUG si trova qui: https://github.com/harvard-acc/smaug

Riporto qui le simulazioni fatte riguardo CNN10 una rete neurale convoluzionale costruita per il dataset CIFAR-10.

Per scongiurare errori di configurazione parto dalla configurazione fornita da SMAUG per Minerva ed effettuo i cambiamenti minimi necessari per simulare la nuova rete con la configurazione hardware desiderata.

Partendo dalla configurazione di Minerva:
- Ho copiato la cartella dandogli nome cnn10-smv:
- Qui ho editato il model_file per settare i modelli corretti e basta questa modifica, rieseguire il trace e lanciare la simulazione per eseguire cnn10 sul backend smv base.
SMV è un backend di ispirazione a NVDLA e dovrebbe avere 8 unità di processamento accelera questi compiti.

- Ho copiato cnn10-smv in cnn10-smv-systolic
- Qui è necessario modificare trace.sh e run.sh aggiungendo --use-systolic-array per usare l’array sistolico.
- È necessario inoltre aggiungere la configurazione dell’array sistolico a gem5.cfg (si copia-incolla da un’altro file presente in SMAUG “systolic-array.cfg” che non riporto).
L’array sistolico sostituisce SMV nell’accelerazione solo delle convoluzioni, gli sviluppatori di SMAUG non hanno implementato anche l’accelerazione dello strato completamente connesso.

I repository così come riportati usano degli script un po’ convoluti perché vanno a ritrovare la posizione di alcuni file all’interno dell’immagine docker, si potrebbero rendere più semplici ma come detto al fine di scongiurare miei errori li uso quasi così come sono dati con piccole modifiche.
Bisogna quindi copiare questa cartella al path /workspace/smaug/experiments/sims nel volume Docker di SMAUG.
Per copiare i file/cartelle bisogna usare docker cp path:sorgente path:destinazione.
