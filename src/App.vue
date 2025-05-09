<template>
  <div id="app">
    <header>
      <h1><img src="fe1b7179-953a-4beb-8959-d6e897d3d619.png" alt="VeriCook" class="logo"></h1>
      <div class="powered-by-google">
        <img src="https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png" alt="Google logo" height="20">
        <span>Powered by Google</span>
      </div>
    </header>

    <div>
      <input
        type="text"
        v-model="query"
        placeholder="Enter search query"
      />
      <button @click="search">Search</button>
    </div>
    <h2 v-if="results.length">「{{query}}」の検索結果</h2>
    <article class="result" v-for="(result, index) in results" :key="index">
      <div class="result-header">
        <div class="meta">
          <span class="sitename">{{ result.site_name }}</span>
          <small class="domain">{{ result.displayLink }}</small>
        </div>
        <h3><a :href="result.link" target="_blank">{{ result.title }}</a></h3>
        <p class="description">{{ result.description }}</p>
      </div>
      <img :src="result.thmbnail" :alt="result.title" class="thmbnail" />
    </article>

    <div v-if="results.length > 0" class="pagination">
      <button :disabled="currentPage === 1" @click="changePage(currentPage)">Previous</button>
      <span>Page {{ currentPage }} of {{ totalPages }}</span>
      <button :disabled="currentPage === totalPages" @click="changePage(currentPage + 1)">Next</button>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      query: "",
      results: [],
      currentPage: 1,
      resultsPerPage: 10,
      totalResults: 0,
      nextIndex: 0,
    };
  },
  computed: {
    totalPages() {
      return Math.ceil(this.totalResults / this.resultsPerPage);
    },
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
      )}&key=${apiKey}&cx=${cx}&start=${this.nextIndex}`;

      try {
        const response = await fetch(url);
        const data = await response.json();
        if (data.items) {
          console.log(data);
          this.results = data.items.map((item) => ({
            title: item.title,
            link: item.link,
            site_name: item.pagemap?.metatags?.[0]?.["og:site_name"],
            description: item.snippet,
            displayLink: item.displayLink,
            thmbnail: item.pagemap?.cse_thumbnail?.[0]?.src || "https://placehold.jp/150x150.png",
          }));

          this.totalResults = data.queries.nextPage[0].totalResults
          this.nextIndex = data.queries.nextPage[0].startIndex
          this.currentPage = parseInt(data.queries.request[0].startIndex/10+1);
        } else {
          this.results = [];
          alert("No results found.");
        }
      } catch (error) {
        console.error("Error fetching search results:", error);
        alert("An error occurred while fetching search results.");
      }
    },
    changePage(page) {
      this.currentPage = page;
      this.search();
    },
  },
};
</script>

<style>
#app {
  font-family: Arial, sans-serif;
  margin-top: 50px;
}

@media (min-width: 800px) {
  #app {
    margin: 0 auto;
    max-width: 800px;
  }
}

input {
  padding: 8px;
  width: 240px;
  margin-right: 10px;
  border: 1px solid #ddd;
  border-radius: 4px;
}

button {
  padding: 8px 16px;
  border: 1px solid #ddd;
  border-radius: 4px;
}

article {
  max-width: 800px;
  display: flex;
  margin-top: 18px;
}

a {
  text-decoration: none;
  color: #007bff;
}

a:hover {
  text-decoration: underline;
}

h3 {
  margin-top: 4px;
  font-size: 20px;
}

.sitename, .domain {
  font-size: 12px;
  color: #555;
}

.logo {
  width: 200px;
  height: auto;
  margin-top: 4px;
}

.description {
  font-size: 14px;
  color: #333;
}

.thmbnail {
  width: 92px;
  height: 92px;
  object-fit: cover;
  border-radius: 8px;
}

/* 既存のスタイルに加えてページング用のスタイルを追加 */
.pagination {
  display: flex;
  justify-content: center;
  align-items: center;
  margin-top: 20px;
}

.pagination button {
  padding: 8px 16px;
  margin: 0 10px;
  border: 1px solid #ddd;
  border-radius: 4px;
  background-color: #f8f8f8;
  cursor: pointer;
}

.pagination button:disabled {
  background-color: #e0e0e0;
  cursor: not-allowed;
}

.pagination span {
  font-size: 14px;
}
</style>