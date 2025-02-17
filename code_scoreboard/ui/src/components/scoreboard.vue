<template>
    <main class="box">
      <section class="scoreboard">
        
        <div class="overlap-group">
          <div class="rectangle" aria-hidden="true"></div>
          <!-- <div class="div" aria-hidden="true"></div> -->
          <!-- <div class="rectangle-2" aria-hidden="true"></div> -->
          <img class="min-logga" src="https://r2.fivemanage.com/AEiekmD8fYUwZak9KWlAV/images/minlogga.png" alt="" aria-hidden="true" />
          <img class="img" src="https://cdn.discordapp.com/avatars/605745501723426821/14f18adca0a654d0f1dc5ffb24f64185.png?size=1024&format=webp&quality=lossless" alt="Logo" />
          <!-- <img class="min-logga-2" src="https://r2.fivemanage.com/AEiekmD8fYUwZak9KWlAV/images/minlogga.png" alt="Logo" /> -->
          <h2 class="text-wrapper">Melonen</h2>
          <!-- <h2 class="text-wrapper-2">Melonen</h2> -->
          <p class="text-wrapper-3">Code Development</p>
          <!-- <p class="text-wrapper-4">Code Development</p> -->
          <!-- <p class="text-wrapper-5" aria-label="Score">
            10 <i class="fa-solid fa-wifi"></i></p>    -->
          <div class="rectangle-3" aria-hidden="true"></div>
          <!-- <div class="rectangle-4" aria-hidden="true"></div> -->
          <p class="text-wrapper-6" aria-label="ID">1</p>
          <!-- <p class="text-wrapper-7" aria-label="Level">1</p> -->
          <div class="rectangle-5" aria-hidden="true"></div>
          <div class="rectangle-6" aria-hidden="true"></div>
          <div class="rectangle-7" aria-hidden="true"></div>
          <div class="rectangle-8" aria-hidden="true"></div>
          <div class="rectangle-9" aria-hidden="true"></div>
          <div class="rectangle-10" aria-hidden="true"></div>
          <div class="rectangle-11" aria-hidden="true"></div>
          <h3 class="text-wrapper-8">Staffs</h3>
          <h3 class="text-wrapper-9">Police</h3>
          <h3 class="text-wrapper-10">Players</h3>          
          <input type="text" id="search" class="text-wrapper-11" placeholder="Search.." />
          <p class="text-wrapper-12" aria-label="Staff count">1</p>
          <p class="text-wrapper-13" aria-label="Police count">1</p>
          <p class="text-wrapper-14" aria-label="Player count">1</p>
          <div class="rectangle-12" aria-hidden="true"></div>
          <img class="connect" src="" alt="Connection status" />
          <div class="players-section"></div>
        </div>
      </section>
    </main>
</template>

<script>
export default {
    data() {
        return {
            players: []
        };
    },
    mounted() {
        document.addEventListener("DOMContentLoaded", this.init);
    },
    methods: {
        async fetchPlayers() {
            try {
                const response = await fetch(`https://${GetParentResourceName()}/getPlayers`, {
                    method: "POST",
                    headers: { "Content-Type": "application/json" }
                });

                if (!response.ok) {
                    throw new Error(`HTTP error! Status: ${response.status}`);
                }

                const text = await response.text();
                if (!text) {
                    throw new Error("Empty response from server.");
                }

                const data = JSON.parse(text);
                if (data && Array.isArray(data.players)) {
                    this.players = data.players;
                    this.loadPlayers(this.players);
                    this.updatePlayerAvatar(data.avatar);
                } else {
                    console.warn("Received unexpected data format:", data);
                }
            } catch (error) {
                console.error("Failed to fetch players:", error);
            }
        },
        updatePlayerAvatar(avatarUrl) {
            if (avatarUrl) {
                document.querySelector(".img").src = avatarUrl;
            }
        },
        countPlayersByGroup(groupNames) {
            return this.players.filter(player => groupNames.includes(player.group)).length;
        },
        countPlayersByJob(job) {
            return this.players.filter(player => player.job === job).length;
        },
        updateCounts() {
            document.querySelector(".text-wrapper-12").textContent = this.countPlayersByGroup(["superadmin", "mod", "admin"]);
            document.querySelector(".text-wrapper-13").textContent = this.countPlayersByJob("police");
            document.querySelector(".text-wrapper-14").textContent = this.players.length;
        },
        getPingColor(ping) {
            if (ping > 100) return "red";
            if (ping > 50) return "yellow";
            return "green";
        },
        formatGroupName(group) {
            if (group === "superadmin" || group === "admin") {
                return "Administrator";
            } else if (group === "mod") {
                return "Moderator";
            }
            return group;
        },
        createPlayerCard(player, index) {
            const pingColor = this.getPingColor(player.ping);
            const formattedGroup = this.formatGroupName(player.group);

            return `
                <div class="player-card" style="animation: slideInFromLeft 0.5s ease-out ${0.2 * index + 0.5}s forwards;">
                    <img class="player-avatar" src="${player.avatar}" alt="Player Avatar">
                    <div class="player-info">
                        <h2 class="player-name">${player.name}</h2>
                        <p class="player-role">${formattedGroup}</p> 
                    </div>
                    <div class="player-stats">
                        <div class="player-id">${player.id}</div>
                        <p class="player-ping" style="color: ${pingColor};">
                            ${player.ping} <i class="fa-solid fa-wifi" style="color: ${pingColor};"></i>
                        </p>
                    </div>
                </div>
            `;
        },
        loadPlayers(filteredPlayers = this.players) {
            const playersSection = document.querySelector(".players-section");
            playersSection.innerHTML = "";

            filteredPlayers.forEach((player, index) => {
                playersSection.innerHTML += this.createPlayerCard(player, index);
            });

            this.updateCounts();
        },
        updatePlayerID(playerID) {
            if (playerID) {
                document.querySelector(".text-wrapper-6").textContent = playerID;
            }
        },
        updatePlayerName(playerName) {
            if (playerName) {
                document.querySelector(".text-wrapper").textContent = playerName;
            }
        },
        init() {
            this.fetchPlayers();

            window.addEventListener("message", (event) => {
                if (event.data.action === "updateJobTitle") {
                    document.querySelector(".text-wrapper-3").textContent = event.data.jobTitle;
                }
            });

            fetch(`https://${GetParentResourceName()}/getJobTitle`, {
                method: "POST",
                headers: { "Content-Type": "application/json" }
            });

            window.addEventListener("message", (event) => {
                if (event.data.action === "updateConnectionImage") {
                    document.querySelector(".connect").src = event.data.connectionImage;
                }
            });

            fetch(`https://${GetParentResourceName()}/getConnectionImage`, {
                method: "POST",
                headers: { "Content-Type": "application/json" }
            });

            document.getElementById("search").addEventListener("input", (event) => {
                const searchText = event.target.value.toLowerCase();
                const filteredPlayers = this.players.filter(player => player.name.toLowerCase().includes(searchText));
                this.loadPlayers(filteredPlayers);
            });

            window.addEventListener("message", (event) => {
                if (event.data.action === "showscoreboard") {
                    document.querySelector(".scoreboard").classList.remove("hidden");
                    this.fetchPlayers();
                } else if (event.data.action === "hidescoreboard") {
                    document.querySelector(".scoreboard").classList.add("hidden");
                } else if (event.data.action === "updateAvatar") {
                    this.updatePlayerAvatar(event.data.avatar);
                } else if (event.data.action === "updatePlayerName") {
                    this.updatePlayerName(event.data.name);
                } else if (event.data.action === "updatePlayerID") {
                    this.updatePlayerID(event.data.id);
                }
            });

            document.addEventListener("keydown", (event) => {
                if (event.key === "Escape") {
                    fetch(`https://${GetParentResourceName()}/hideScoreboard`, {
                        method: "POST",
                        headers: { "Content-Type": "application/json" },
                        body: JSON.stringify({})
                    });
                }
            });

            document.querySelector(".scoreboard").classList.add("hidden");
        }
    }
};
</script>


<style>
.box {
    position: absolute;
    top: 63%;
    left: 16%;
    transform: translate(-50%, -50%);
    user-select: none;
}

.box .scoreboard {
  position: fixed;
  width: 1400px; 
  height: 800px; 
  top: 0;
  left: 0;
  user-select: none;
  /* display: none; */
}

  

.box .overlap-group {
  position: relative;
  width: 1380px;
  height: 800px; 
  user-select: none;
}
  
  .box .rectangle {
    position: absolute;
    width: 1378px;
    height: 729px;
    top: 71px;
    left: 0;
    background-color: #00000099;
    border-radius: 0px 0px 3px 3px;
    border: 1px solid;
    border-color: #000000;
    filter: blur(2px);
    user-select: none;

  }
  
  .box .div {
    position: absolute;
    width: 295px;
    height: 64px;
    top: 176px;
    left: 13px;
    background-color: #00000099;
    border-radius: 2px;
    user-select: none;

  }
  
  .box .rectangle-2 {
    position: absolute;
    width: 1355px;
    height: 65px;
    top: 88px;
    left: 13px;
    background-color: #00000099;
    border-radius: 2px;
    user-select: none;

  }
  
  .box .min-logga {
    width: 1px;
    height: 1px;
    top: 135px;
    left: 37px;
    position: absolute;
    object-fit: cover;
    user-select: none;

  }
  
  .box .img {
    width: 48px;
    height: 48px;
    top: 96px;
    left: 16px;
    position: absolute;
    object-fit: cover;
    user-select: none;
    border-radius: 5px;
  }
  
  .box .min-logga-2 {
    width: 48px;
    height: 48px;
    top: 184px;
    left: 22px;
    position: absolute;
    object-fit: cover;
    user-select: none;

  }
  
  .box .text-wrapper {
    top: 96px;
    position: absolute;
    left: 70px;
    font-family: "Poppins", Helvetica;
    font-weight: 900;
    color: #ffffff;
    font-size: 11px;
    letter-spacing: 0;
    line-height: normal;
    white-space: nowrap;
    user-select: none;
  }
  
  .box .text-wrapper-2 {
    top: 183px;
    position: absolute;
    left: 70px;
    font-family: "Poppins", Helvetica;
    font-weight: 900;
    color: #ffffff;
    font-size: 11px;
    letter-spacing: 0;
    line-height: normal;
    white-space: nowrap;
    user-select: none;
  }
  
  .box .text-wrapper-3 {
    position: absolute;
    top: 115px;
    left: 70px;
    font-family: "Poppins", Helvetica;
    font-weight: 600;
    color: #ffffff80;
    font-size: 10px;
    letter-spacing: 0;
    line-height: normal;
    white-space: nowrap;
    user-select: none;
  }
  
  .box .text-wrapper-4 {
    position: absolute;
    top: 200px;
    left: 68px;
    font-family: "Poppins", Helvetica;
    font-weight: 600;
    color: #ffffff80;
    font-size: 10px;
    letter-spacing: 0;
    line-height: normal;
    white-space: nowrap;
    user-select: none;
  }
  
  .box .text-wrapper-5 {
    top: 182px;
    left: 258px;
    color: #00ff00;
    font-size: 15px;
    white-space: nowrap;
    position: absolute;
    font-family: "Poppins", Helvetica;
    font-weight: 600;
    letter-spacing: 0;
    line-height: normal;
    user-select: none;
  }
  
  .box .rectangle-3 {
    position: absolute;
    width: 28px;
    height: 21px;
    top: 101px;
    left: 160px;
    background-color: #7c0b0b75;
    border-radius: 3px;
    user-select: none;
  }
  
  .box .rectangle-4 {
    position: absolute;
    width: 28px;
    height: 21px;
    top: 189px;
    left: 125px;
    background-color: #7c0b0b75;
    border-radius: 3px;
    user-select: none;
  }
  
  .box .text-wrapper-6 {
    position: absolute;
    top: 92px;
    left: 170px;
    color: #ffffff;
    font-size: 14px;
    font-family: "Poppins", Helvetica;
    font-weight: 700;
    letter-spacing: 0;
    line-height: normal;
    text-align: center;
    user-select: none;
    margin-top: 10px;
}

  .box .text-wrapper-7 {
    top: 180px;
    left: 135px;
    color: #ffffff;
    font-size: 13px;
    position: absolute;
    font-family: "Inter-SemiBold", Helvetica;
    font-weight: 600;
    letter-spacing: 0;
    line-height: normal;
    user-select: none;
  }
  
  .box .rectangle-5 {
    position: absolute;
    width: 232px;
    height: 36px;
    top: 101px;
    left: 279px;
    background-color: #00000099;
    border-radius: 4px;
    user-select: none;
  }
  
  .box .rectangle-6 {
    position: absolute;
    width: 232px;
    height: 36px;
    top: 101px;
    left: 530px;
    background-color: #00000099;
    border-radius: 4px;
    user-select: none;
  }
  
  .box .rectangle-7 {
    position: absolute;
    width: 232px;
    height: 36px;
    top: 101px;
    left: 780px;
    background-color: #00000099;
    border-radius: 4px;
    user-select: none;
  }
  
  .box .rectangle-8 {
    position: absolute;
    width: 232px;
    height: 36px;
    top: 100px;
    left: 1040px;
    background-color: #000000b2;
    border-radius: 4px;
    user-select: none;
  }
  
  .players-section {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 10px;
    justify-content: center;
    align-items: start;
    padding: 10px;
    width: 95%;
    position: absolute;
    top: 17vh;
    left: 15px;
    z-index: 9999;
    max-height: 600px;
    overflow-y: auto;
    max-width: 115%;
    /* overflow: hidden; */
}

.players-section:has(.player-card:nth-child(2):last-child) {
  justify-content: space-around;
}



.players-section,
.scoreboard {
  pointer-events: auto !important;
}


.scoreboard {
  overflow: hidden;
}


.players-section::-webkit-scrollbar {
  width: 8px;
}

.players-section::-webkit-scrollbar-thumb {
  background-color: rgba(182, 17, 17, 0.3);
  border-radius: 4px;
}

.players-section::-webkit-scrollbar-track {
  background: transparent;
}



@keyframes slideInFromLeft {
  from {
      opacity: 0;
      transform: translateX(-50px);
  }
  to {
      opacity: 1;
      transform: translateX(0);
  }
}

.player-card {
  width: 95%;
  min-height: 70px;
  background: rgba(0, 0, 0, 0.7);
  padding: 10px;
  border-radius: 5px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  opacity: 0;
}


@media (max-width: 1024px) {
  .players-section {
      grid-template-columns: repeat(2, 1fr);
      justify-content: space-evenly; 
      gap: 50px; 
  }
}

.player-avatar {
    width: 48px;
    height: 48px;
    object-fit: cover;
    border-radius: 5px;
}

.player-info {
    flex: 1;
    margin-left: 10px;
}

.player-name {
    font-family: "Poppins", Helvetica;
    font-weight: 900;
    color: white;
    font-size: 14px;
    margin-bottom: -10px;
}

.player-role {
    font-family: "Poppins", Helvetica;
    font-weight: 600;
    color: rgba(255, 255, 255, 0.7);
    font-size: 12px;
}

.player-stats {
    display: flex;
    align-items: center;
    gap: 10px;
}

.player-id {
    background: rgba(124, 11, 11, 0.75);
    padding: 5px 10px;
    border-radius: 3px;
    font-size: 13px;
    color: white;
    width: 20px;
    font-family: "Poppins", Helvetica;
    font-weight: 600;
    margin-left: 20px;
    text-align: center;
}

.player-ping {
    font-family: "Poppins", Helvetica;
    font-weight: 600;
    color: #00ff00;
    font-size: 15px;
    display: flex;
    align-items: center;
    gap: 5px;
}



  .box .rectangle-9 {
    position: absolute;
    width: 40px;
    height: 23px;
    top: 108px;
    left: 405px;
    background-color: #7d131382;
    border-radius: 2px;
    user-select: none;
  }
  
  .box .rectangle-10 {
    position: absolute;
    width: 40px;
    height: 23px;
    top: 108px;
    left: 650px;
    background-color: #7d131382;
    border-radius: 2px;
    user-select: none;
  }
  
  .box .rectangle-11 {
    position: absolute;
    width: 40px;
    height: 23px;
    top: 108px;
    left: 895px;
    background-color: #7d131382;
    border-radius: 2px;
    user-select: none;
  }
  
  .box .text-wrapper-8 {
    position: absolute;
    width: 105px;
    top: 97px;
    left: 357px;
    font-family: "Inter-SemiBold", Helvetica;
    font-weight: 600;
    color: #ffffff;
    font-size: 14px;
    letter-spacing: 0;
    line-height: normal;
    white-space: nowrap;
    user-select: none;
  }
  
  .box .text-wrapper-9 {
    position: absolute;
    width: 105px;
    top: 97px;
    left: 600px;
    font-family: "Inter-SemiBold", Helvetica;
    font-weight: 600;
    color: #ffffff;
    font-size: 14px;
    letter-spacing: 0;
    line-height: normal;
    white-space: nowrap;
    user-select: none;
  }
  
  .box .text-wrapper-10 {
    position: absolute;
    width: 105px;
    top: 97px;
    left: 835px;
    font-family: "Inter-SemiBold", Helvetica;
    font-weight: 600;
    color: #ffffff;
    font-size: 14px;
    letter-spacing: 0;
    line-height: normal;
    white-space: nowrap;
    user-select: none;
  }
  
  .box .text-wrapper-11 {
    position: absolute;
    width: 200px;
    top: 105px;
    left: 800px;
    font-family: "Inter-SemiBold", Helvetica;
    font-weight: 600;
    color: #ffffff;
    font-size: 14px;
    letter-spacing: 0;
    line-height: normal;
    white-space: nowrap;
    user-select: none;
  }
  .box .text-wrapper-12 {
    width: 105px;
    top: 97px;
    left: 420px;
    color: #ffffff;
    font-size: 14px;
    white-space: nowrap;
    position: absolute;
    font-family: "Inter-SemiBold", Helvetica;
    font-weight: 600;
    letter-spacing: 0;
    line-height: normal;
    user-select: none;
  }
  
  .box .text-wrapper-13 {
    width: 105px;
    top: 97px;
    left: 665px;
    color: #ffffff;
    font-size: 14px;
    white-space: nowrap;
    position: absolute;
    font-family: "Inter-SemiBold", Helvetica;
    font-weight: 600;
    letter-spacing: 0;
    line-height: normal;
    user-select: none;
  }
  
  .box .text-wrapper-14 {
    width: 105px;
    top: 97px;
    left: 910px;
    color: #ffffff;
    font-size: 14px;
    white-space: nowrap;
    position: absolute;
    font-family: "Inter-SemiBold", Helvetica;
    font-weight: 600;
    letter-spacing: 0;
    line-height: normal;
    user-select: none;
  }
  
  .box .vector {
    position: absolute;
    width: 19px;
    height: 13px;
    top: 200px;
    left: 281px;
    user-select: none;
  }
  
  .box .rectangle-12 {
    position: absolute;
    width: 1355px;
    height: 2px;
    top: 164px;
    left: 13px;
    background-color: #ffffff66;
    border-radius: 5px;
    user-select: none;
  }
  
  .box .connect {
    position: absolute;
    width: 1380px;
    height: 80px;
    top: 0;
    left: 0;
    object-fit: cover;
    user-select: none;
    border-radius: 5px;
  }
  
  .box .vector-2 {
    position: absolute;
    width: 18px;
    height: 18px;
    top: 110px;
    left: 994px;
    user-select: none;
  }

  
  .visually-hidden {
    position: absolute !important;
    height: 1px;
    width: 1px;
    padding: 0;
    margin: 0;
    overflow: hidden;
    clip: rect(1px, 1px, 1px, 1px);
    white-space: nowrap;
    border: 0;
    user-select: none;
}

  
  .box {
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
    user-select: none;
  }
  
  @keyframes fadeIn {
    from {
        opacity: 0;
    }
    to {
        opacity: 1;
    }
  }
  
  @keyframes fadeOut {
    from {
        opacity: 1;
    }
    to {
        opacity: 0;
    }
  }

  .scoreboard {
    position: relative;
    width: 1276px;
    height: 699px;
    user-select: none;
    animation: fadeIn 0.5s ease-out forwards;
    opacity: 0; 
    pointer-events: none;
  }
  
  .scoreboard.hidden {
    animation: fadeOut 0.5s ease-out forwards;
    opacity: 0;
    pointer-events: none;
}



  
  .overlap-group {
    position: relative;
    width: 1248px;
    height: 699px;
    background-color: rgba(0, 0, 0, 0);
    border-radius: 0 0 3px 3px;
    border: 1px solid #000000;
    user-select: none;
  }
  
  input[type="text"].text-wrapper-11 {
    background-color: transparent;
    border: none;  
    outline: none;   
    color: #ffffff;
    font-family: "Inter-SemiBold", Helvetica;
    font-size: 14px;
    font-weight: 600;
    width: 18%;
    left: 76%;
    padding: 5px;
    user-select: none;
    pointer-events: auto !important;
    z-index: 9999 !important;
    position: relative;
  }
  
  input[type="text"].text-wrapper-11::placeholder {
    color: #ffffff;
    opacity: 0.7;
    user-select: none;
  }

  
  .box .vector-2 {
    pointer-events: none;
    user-select: none;
  }
  
  @media (max-width: 1280px) {
    .scoreboard,
    .overlap-group {
      width: 100%;
      height: auto;
    }
  }
</style>