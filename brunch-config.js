exports.config = {
  files: {
    stylesheets: {
      joinTo: "css/app.css",
      order: {
        after: ["web/static/css/app.css"]
      }
    }
  },

  conventions: {
    assets: /^(web\/static\/assets)/
  },

  paths: {
    watched: [
      "web/static",
      "test/static"
    ],
    public: "priv/static"
  },

  npm: {
    enabled: true
  }
};
