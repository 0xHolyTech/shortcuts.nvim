# Project Level Shortcuts in NVIM

Create dynamic shortcuts for your projects that can be redefined on the fly.

## Shortcuts.nvim

You can define a simple prefix for your shortcuts, after which the system will try to find the custom shortcuts you wish to use. For example, lets say you use `<leader>a` as a prefix, a follow up with `b` for building the project. Usually, this would need to be a hard coded command, but here you can define build however you want. Be it a Makefile command, doit command, bash script, docker up with parameters.

In the end, you can do this for all of your usual project needs. Linting, building, testing, deploying and more.

## Future tasks
Although the current project is more or less what I needed, it still has quite a few annoying issues. These will be listed below and removed as they are fixed.

- [ ] Overwrite commands after being modified.
- [ ] Remove commands after being deleted.
- [ ] Better defaults (probably make file defaults)
- [ ] Allow configuring through setup()
- [ ] Cleaner edit board, parsed from json and then written back to json on save

