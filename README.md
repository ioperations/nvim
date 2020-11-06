 ```bash
 _   _       _           
| \ | |_   _(_)_ __ ___  
|  \| \ \ / / | '_ ` _ \ 
| |\  |\ V /| | | | | | |
|_| \_| \_/ |_|_| |_| |_|

 ```


#### Installation
```bash
bash <(curl -sLf https://git.io/JTvvG)
```
#### Install manually by __[DetailInstalltion](./doc.md)__


#### Basic navigation
- [line & char] __h__,__j__,__k__,__l__ for __left__, __down__ ,__up__, __right__
- [word ] __w__,__b__,__e__, for __Word__,__Back__,__Next_Word_Tail__

#### Source trace based on lsp [coc.nvim](https://github.com/neoclide/coc.nvim)

- __`<leader>ld`__ for go to definition
- __`<leader>lr`__ for go to reference
- __`<leader>lD`__ for go to Declaration
- __`<leader>li`__ for go to implemention

<img align="center" width=280px src="./res/gotodefination.gif">
<img align="center" width=280px src="./res/gotoreference.gif">


#### Search
- __`<ctrl-g>`__ for project-wide Symbol Search by __[ripgrep](https://github.com/BurntSushi/ripgrep)__
- __`<ctrl-p>`__ for project-wide file Search by __[fzf](https://github.com/junegunn/fzf)__
- __`<leader>rr`__ for ranger-based search by __[ranger](https://github.com/ranger/ranger)__

<img align="center" width=280px src="./res/symbolsearch.gif">
<img align="center" width=280px src="./res/searchfilebyranger.gif">
<img align="center" width=280px src="./res/searhpathbyfzf.gif">

#### Git staff
- __`<leader>gD`__ for git-based diff
- __`<leader>gm`__ for git-based message
- __`<leader>gg`__ for git-based grep
- __`<leader>gh`__ for git-diff-based highlight
- __`<leader>gl`__ for git log

<img align="center" width=280px src="./res/showgitmessage.gif">
<img align="center" width=280px src="./res/gitDiff.gif">

#### Task by [AsyncTask](https://github.com/skywind3000/asynctasks.vim)
- __`<leader>kl`__ for **`list all defined task`**
- __`<leader>ke<Cr>`__ for **`edit local task`**
- __`<leader>kg<Cr>`__ for **`edit global task`**

<img align="center" width=380px src="./res/taskbuild.gif">

#### Others cool staff
- __`<leader>lv`__ for language translation provided by __[coc.nvim](https://github.com/neoclide/coc.nvim)__

<img align="center" width=320px src="./res/translate.gif">
