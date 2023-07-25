# aspace_tree_endpoint
Revive the deprecated resource tree endpoint for ArchivesSpace API

`/repositories/:id/resources/:id/tree` was removed from ArchivesSpace:
https://github.com/archivesspace/archivesspace/pull/2774

This plugin restores the endpoint. Check this repository out to your
`plugins` directory and add this line to your `config.rb` file:

```
AppConfig[:plugins] << 'aspace_tree_endpoint'
```

