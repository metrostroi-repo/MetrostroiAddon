Metrostroi Subway Simulator 2026
================================================================================

## Working branches:
- `unstable` - Development branch. Contains all last changes, not tested and very unstable. Stable work not guaranteed, use at your own risk.
- `dev` - Stable development branch. All changes are reviewed and tested, but may contain bugs. Can use on servers.
- `release` - Stable branch. Code for Steam Workshop.

## Licensing
### Models and materials
All models, materials and sounds belong to their corresponding authors. Used with
permission for purposes of prototyping a subway train simulator inside Garry's-Mod only.


## Workaround for  `This repository exceeded its LFS budget`
```bash
git config lfs.url https://git.metrostroi.net/metrostroi-repo/MetrostroiAddon.git/info/lfs
git lfs fetch
git reset --hard
git config lfs.url https://github.com/metrostroi-repo/MetrostroiAddon.git/info/lfs
```
**Warning:** This will discard all your local changes in the working copy and the index!
