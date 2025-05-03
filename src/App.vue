<template>
  <div id="app">
    <h1>Google Search</h1>
    <div>
      <input
        type="text"
        v-model="query"
        placeholder="Enter search query"
      />
      <button @click="search">Search</button>
    </div>
    <ul v-if="results.length">
      <li v-for="(result, index) in results" :key="index">
        <a :href="result.link" target="_blank">
          {{ result.title }}
        </a>
      </li>
    </ul>
    
  </div>
</template>

<script>
export default {
  data() {
    return {
      query: "",
      results: [],
    };
  },
  methods: {
    async search() {
      if (!this.query) {
        alert("Please enter a search query.");
        return;
      }

      const apiKey = process.env.VUE_APP_GOOGLE_API_KEY;
      const cx = process.env.VUE_APP_GOOGLE_API_CX;

      if (!apiKey || !cx) {
        alert("API key or CX is missing. Please check your environment variables.");
        return;
      }

      const url = `https://www.googleapis.com/customsearch/v1?q=${encodeURIComponent(
        this.query
      )}&key=${apiKey}&cx=${cx}`;

      try {
        const response = await fetch(url);
        const data = await response.json();
        if (data.items) {
          console.log(data);
          this.results = data.items.map((item) => ({
            title: item.title,
            link: item.link,
          }));
        } else {
          this.results = [];
          alert("No results found.");
        }
      } catch (error) {
        console.error("Error fetching search results:", error);
        alert("An error occurred while fetching search results.");
      }
    },
  },
};
</script>

<style>
#app {
  font-family: Arial, sans-serif;
  text-align: center;
  margin-top: 50px;
}

input {
  padding: 8px;
  width: 300px;
  margin-right: 10px;
}

button {
  padding: 8px 16px;
}

ul {
  list-style-type: none;
  padding: 0;
}

li {
  margin: 10px 0;
}

a {
  text-decoration: none;
  color: #007bff;
}

a:hover {
  text-decoration: underline;
}
</style>