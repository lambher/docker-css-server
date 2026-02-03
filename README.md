# Counter-Strike: Source Docker Server

Serveur Counter-Strike: Source (CS:S) conteneurise avec Docker, incluant SourceMod et Metamod pour la gestion de plugins et d'administration.

## Fonctionnalites

- Serveur CS:S SRCDS complet
- SourceMod pre-installe (administration, votes, chat)
- Metamod:Source pour le chargement de plugins
- Mode Deathmatch (CSSDM) inclus
- Maps personnalisees (belair)
- Configuration facile via variables d'environnement

## Demarrage rapide

### 1. Configuration

Copiez le fichier d'exemple et configurez vos parametres:

```bash
cp .env.example .env
```

Editez `.env` avec vos valeurs:

```env
RCON_PASSWORD=votre_mot_de_passe_rcon
SERVER_HOSTNAME="Mon Serveur CSS"
SV_PASSWORD=            # Laisser vide pour serveur public
```

### 2. Lancement

```bash
docker-compose up -d
```

### 3. Connexion

Connectez-vous au serveur via la console CS:S:
```
connect votre_ip:27015
```

## Configuration

### Variables d'environnement

| Variable | Description | Obligatoire |
|----------|-------------|-------------|
| `RCON_PASSWORD` | Mot de passe admin RCON | Oui |
| `SERVER_HOSTNAME` | Nom affiche dans le navigateur de serveurs | Oui |
| `SV_PASSWORD` | Mot de passe serveur (vide = public) | Non |

### Ports

| Port | Protocole | Description |
|------|-----------|-------------|
| 27015 | TCP/UDP | Port de jeu principal |
| 27005 | UDP | Port RCON |

### Fichiers de configuration

- `cfg/server.cfg` - Configuration principale du serveur
- `cfg/mapcycle.txt` - Rotation des maps
- `cfg/my-server.cfg` - Vos personnalisations (charge apres server.cfg)

## Administration

### SourceMod

Le serveur inclut SourceMod pour l'administration. Commandes de chat:
- `!admin` - Menu d'administration
- `!vote` - Lancer un vote
- `!nextmap` - Voir la prochaine map

### Ajouter un administrateur

Editez `addons/sourcemod/configs/admins.cfg`:

```
Admins
{
    "MonPseudo"
    {
        "auth"      "steam"
        "identity"  "STEAM_0:1:12345678"
        "flags"     "abcdefghijklmnopqrstz"
        "immunity"  "99"
    }
}
```

Trouvez votre SteamID sur [steamid.io](https://steamid.io/).

### Flags administrateur

| Flag | Permission |
|------|------------|
| a | Reservation de slot |
| b | Kick |
| c | Ban |
| d | Unban |
| e | Slap/Slay |
| f | Changement de map |
| g | Convars |
| z | Root (tous les droits) |

## Structure du projet

```
docker-css-server/
├── Dockerfile              # Image Docker
├── docker-compose.yml      # Configuration Docker Compose
├── entrypoint.sh           # Script de demarrage
├── .env.example            # Template de configuration
├── cfg/                    # Configurations serveur
│   ├── server.cfg
│   ├── mapcycle.txt
│   └── my-server.cfg
├── addons/                 # Plugins serveur
│   ├── metamod/            # Metamod:Source
│   └── sourcemod/          # SourceMod + CSSDM
└── belair_map/             # Maps personnalisees
```

## Developpement

### Build de l'image

```bash
docker build -t css-server .
```

### Logs

```bash
docker-compose logs -f
```

### Acces console

```bash
docker exec -it docker-css-server-server-1 bash
```

## Securite

- Ne committez jamais le fichier `.env` contenant vos mots de passe
- Utilisez un mot de passe RCON fort
- Configurez les administrateurs SourceMod avec authentification Steam
- Gardez SourceMod et Metamod a jour

## Licence

Ce projet utilise:
- [SourceMod](https://www.sourcemod.net/) - GPL v3
- [Metamod:Source](https://www.metamodsource.net/) - GPL v3
- [SteamCMD](https://developer.valvesoftware.com/wiki/SteamCMD)
