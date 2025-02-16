# FiveM Script Pack - Open Source

Välkommen till denna samling av gratis och öppen källkod för FiveM-utvecklingsskript. Detta repository innehåller flera användbara skript för att förbättra din serverupplevelse. Alla skript är optimerade för stabilitet och kompatibilitet med de senaste FiveM-uppdateringarna.

## Innehåll

### 1. Greenzone Script
Ett skript som skapar säkra zoner där vapenanvändning och våld är inaktiverat. Perfekt för RP-servermiljöer där vissa områden, såsom polisstationer eller sjukhus, ska vara konfliktfria.

**Funktioner:**
- Skapa flera gröna zoner
- Automatisk blockering av vapenanvändning
- Visuell markering av zoner

### 2. Killnotify Script
Visar en tydlig notis vid eliminering av spelare, användbart för både RP- och PvP-servrar.

**Funktioner:**
- Visar dödsorsak och vapen
- Anpassningsbar UI
- Stöd för server-wide logs

### 3. Stores Script
Ett grundläggande butiksystem där spelare kan köpa och sälja varor.

**Funktioner:**
- Stöd för flera butiker
- Anpassningsbara varor och priser
- Enkel integration med andra ekonomi- och inventory-system

### 4. StoresV2 Script
En förbättrad version av Stores Script med fler funktioner och bättre optimering.

**Funktioner:**
- Dynamisk varulagerhantering
- Support för rabatter och kampanjer
- Avancerad loggning av transaktioner

### 5. Trygghansa Script
Ett RP-fokuserat försäkringssystem där spelare kan köpa försäkring för sina fordon och egendomar.

**Funktioner:**
- Automatiserad skadehantering
- Möjlighet att köpa olika försäkringsplaner
- Integration med fordonssystem

### 6. Who Script
Ett simpelt men effektivt **/who**-kommando som listar online-spelare med ID och namn.

**Funktioner:**
- Visa en lista med alla online-spelare
- Stöd för administratörsfunktioner
- Enkel implementation

---

## Installation
1. Ladda ner detta repository eller de enskilda skripten du vill använda.
2. Placera skripten i din **resources/**-mapp.
3. Lägg till följande rader i din **server.cfg**:
   ```cfg
   start code_greenzone
   start code_killnotify
   start code_stores
   start code_storesv2
   start code_trygghansa
   start code_who
   ```
4. Starta om din server och njut av funktionerna!

## Anpassning
Alla skript innehåller en **config.lua** eller motsvarande konfigurationsfil där du kan justera inställningar såsom zoner, butiksvaror och UI-element.

## Bidra
Detta projekt är öppen källkod och vi välkomnar bidrag! Om du vill lägga till nya funktioner eller förbättra befintliga skript, skicka gärna en pull request.

## Support
Om du har frågor eller behöver hjälp, tveka inte att skapa ett ärende i detta repository.

**Tack för att du använder dessa FiveM-skript!** 🚀
