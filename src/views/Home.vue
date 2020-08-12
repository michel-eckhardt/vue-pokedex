<template>
  <v-container id="fundo">
    <v-row align="center" justify="center">
      <v-col md="3" align-self="center">
        <v-text-field v-model="search" label="Pokemon Name" solo @keyup.enter="findByName"></v-text-field>
      </v-col>
      <v-col md="1" align-self="start">
        <v-btn large color="#d30a40" dark @click="findByName">Search</v-btn>
      </v-col>
    </v-row>
    <v-row justify="center" align="center">
      <div id="pokedex">
        <img alt="Pokedex" src="../assets/pokedex.png" width="1000vh" />

        <div id="pokemon">
          <img height="181vh" :src="pokemonUrl" />
        </div>

        <div id="stats">
          <span v-for="status in stats" v-bind:key="status.id">
            {{status.stat.name}} : {{status.base_stat}}
            <br />
          </span>
        </div>

        <div id="pokemonName">
          <h3>{{pokemonName}}</h3>
        </div>

        <div id="next">
          <button @click="nextPokemon"></button>
        </div>
        <div id="prev">
          <button @click="previusPokemon"></button>
        </div>

        <div id="pokemonType1">
          <h3>{{pokemonType1}}</h3>
        </div>

        <div id="pokemonType2">
          <h3>{{pokemonType2}}</h3>
        </div>
      </div>
    </v-row>
  </v-container>
</template>


<script>
import axios from "axios";

export default {
  data: () => ({
    search: "",
    pokemonUrl: "https://pngimg.com/uploads/pokeball/pokeball_PNG24.png",
    pokemonName: "",
    pokemonType1: "",
    pokemonType2: "",
    pokemonId: 0,
    stats: [],
  }),
  methods: {
    nextPokemon() {
      this.find(this.pokemonId + 1);
    },
    previusPokemon() {
      if(this.pokemonId == 1){
        return
      }
      this.find(this.pokemonId - 1);
    },

    findByName() {
      this.find(this.search);
    },

    async find(param) {
      await axios
        .get("https://pokeapi.co/api/v2/pokemon/" + param)
        .then((resp) => {
          this.pokemonUrl =
            "https://pokeres.bastionbot.org/images/pokemon/" +
            resp.data.id +
            ".png";

          this.pokemonId = resp.data.id;
          this.stats = resp.data.stats;
          this.pokemonName = resp.data.name;
          this.pokemonType1 = resp.data.types[0].type.name;
          if (resp.data.types[1]) {
            this.pokemonType2 = resp.data.types[1].type.name;
          } else {
            this.pokemonType2 = "";
          }
        })
        .catch((err) => {
          console.log(err);
          this.pokemonUrl =
            "https://image.freepik.com/free-vector/error-404-found-glitch-effect_8024-4.jpg";
          this.stats = "";
          this.pokemonName = "";
          this.pokemonType1 = "";
          this.pokemonType2 = "";
        });
    },
  },
};
</script>

<style>
#pokedex {
  position: relative;
}
#pokemon {
  position: absolute;
  top: 263px;
  left: 184px;
}

#pokemonName {
  position: absolute;
  bottom: 92px;
  left: 154px;
  color: #084035;
  text-transform: uppercase;
  width: 149px;
  height: 69px;
  text-align: center;
  padding-top: 2%;
}

#stats {
  left: 604px;
  list-style-type: none;
  position: absolute;
  color: #63c27f;
  top: 271px;
  width: 295px;
  height: 109px;
  display: grid;
  grid-template-columns: 50% 50%;
  text-align: left;
  padding: 13px;
  font-size: 14px;
}

#pokemonType1 {
  position: absolute;
  bottom: 101px;
  right: 260px;
  color: #63c27f;
  text-transform: uppercase;
  width: 138px;
  height: 46px;
  text-align: center;
  padding-top: 7px;
}

#pokemonType2 {
  position: absolute;
  bottom: 102px;
  right: 99px;
  color: #63c27f;
  text-transform: uppercase;
  width: 133px;
  height: 44px;
  text-align: center;
  padding-top: 7px;
}

#next button {
  position: absolute;
  bottom: 159px;
  left: 414px;
  width: 39px;
  height: 28px;
}
#prev button {
  position: absolute;
  bottom: 159px;
  left: 345px;
  width: 39px;
  height: 28px;
}
</style>
