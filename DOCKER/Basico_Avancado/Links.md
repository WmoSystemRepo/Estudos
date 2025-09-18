# 📎 Links de Estudo — Docker

Este documento reúne os links de referência usados durante os estudos de **Docker** e ferramentas relacionadas.  
Cada item possui um **resumo técnico** e o link clicável para estudo aprofundado. 🚀

---

## 🌐 Recursos Oficiais

### 🔹 Open Containers Initiative (OCI)  
👉 [Acessar documentação](https://opencontainers.org/)  
A **OCI** define padrões abertos para containers, incluindo formato de imagens e runtime.  
Isso garante portabilidade e compatibilidade entre diferentes ferramentas do ecossistema Docker/Kubernetes.  

---

### 🔹 Docker Storage Drivers — OverlayFS / Overlay2  
👉 [Acessar documentação](https://docs.docker.com/engine/storage/drivers/overlayfs-driver/#how-the-overlay2-driver-works)  
O `overlay2` é o **driver de armazenamento recomendado** para Docker em distribuições Linux modernas.  
- Junta camadas (`lowerdir`, `upperdir`, `merged`) para formar a visão final do container.  
- Suporta até **128 camadas inferiores**.  
- Otimiza espaço e desempenho, compartilhando camadas entre containers.  
- Limitações: operações de escrita podem gerar overhead (“copy-up”), exige FS compatível (ext4/XFS com `d_type=true`).  

---

### 🔹 Docker Network Drivers — MacVLAN  
👉 [Acessar documentação](https://docs.docker.com/engine/network/drivers/macvlan/#8021q-trunk-bridge-mode)  
O driver `macvlan` permite que cada container tenha **endereço MAC próprio**, simulando conexão direta na rede física.  
- Modos: **bridge** (tráfego via interface host) e **802.1Q trunk bridge** (suporte a VLAN tagging).  
- Necessário habilitar modo promíscuo na interface host.  
- Cuidados: conflitos de IP/MAC e restrições na comunicação entre host ↔ containers.  

---

### 🔹 12 Factor App — Logs  
👉 [Acessar documentação](https://12factor.net/logs)  
Princípio dos **12-Factors** aplicado a logs:  
- Logs devem ser tratados como **fluxos contínuos de eventos**.  
- Containers e apps **não devem armazenar logs em disco**; em vez disso, devem enviá-los para stdout/stderr.  
- Ferramentas externas (como ELK, Fluentd, Prometheus) ficam responsáveis pelo armazenamento, rotação e análise.  

---

### 🔹 GNS3 — Instalação em Linux  
👉 [Acessar documentação](https://docs.gns3.com/docs/getting-started/installation/linux/)  
Guia oficial para instalar o **GNS3** em sistemas Linux.  
- Explica dependências necessárias.  
- Métodos de instalação (pacotes, PPA, compilação).  
- Requisitos de hardware e recomendações de rede.  
Ferramenta essencial para simular redes virtuais complexas em laboratório.  

---

### 🔹 GNS3 Marketplace — Open vSwitch Appliance  
👉 [Acessar documentação](https://www.gns3.com/marketplace/appliances/open-vswitch)  
Appliance do **Open vSwitch (OVS)** disponível no marketplace do GNS3.  
- Permite criar topologias de rede avançadas usando switches virtuais.  
- Suporte a VLANs, VXLANs e testes de SDN (Software Defined Networking).  
- Útil em conjunto com Docker, VMs e simulações de ambientes híbridos.  

---

## 🖼️ Arquitetura do Docker Engine

[![Docker Engine Architecture](https://1273418454-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2F-M1LVsv044FMDdyLjX-C%2Fuploads%2Fgit-blob-e3a74418ac900169f422293a8551fa9032af591d%2Fdocker-engine-arch.png?alt=media&token=19c62ad2-4c2a-4b0b-9555-411935e3c896)](https://1273418454-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2F-M1LVsv044FMDdyLjX-C%2Fuploads%2Fgit-blob-e3a74418ac900169f422293a8551fa9032af591d%2Fdocker-engine-arch.png?alt=media&token=19c62ad2-4c2a-4b0b-9555-411935e3c896)

Diagrama oficial da **arquitetura do Docker Engine**: mostra como funcionam os componentes principais (CLI, API, Docker Daemon, container runtime, storage drivers e network drivers).

---

✍️ **Autor:** Wenk Wesley Mendes (Mendes)