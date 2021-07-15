module.exports = {
  header: "# Changelog",
  skip: {
    commit: false,
    tag: true
  },
  scripts: {
    postchangelog: "sed -i '' 's/\\*\\*\\(.*\\)\\*\\*//g' CHANGELOG.md"
  },
  bumpFiles: [
    {
      filename: "pubspec.yaml",
      updater: require.resolve("standard-version-updater-yaml")
    }
  ]
};
