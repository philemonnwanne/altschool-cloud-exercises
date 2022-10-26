# Exercise-05

## Task: 
- You already have Github account, aso setup a GitLab account if you don’t have one already
- You already have a altschool-cloud-exercises project, clone the project to your local system
- Setup your name and email in Git’s global config

## Steps:

- On Github navigate to the repository that you want to clone, in this case (altschool-cloud-exercises)
- Click on the green button which says `Code` and copy the `https` URL

 ![clone-button-image](https://github.com/philemonnwanne/altschool-cloud-exercises/blob/main/Month-02/Exercise-05/images/clone.png)
- Now change switch to the directory where you want your repository cloned
- Then run the `git clone` command and past the `https` URL you copied earlier

```
git clone https://github.com/philemonnwanne/altschool-cloud-exercises.git
```

You have now successfully cloned a github repository


## Output of git config -l

```php
credential.helper=osxkeychain
user.email=philemonnwanne@gmail.com
user.name=philemonnwanne
core.editor=code --wait
core.repositoryformatversion=0
core.filemode=true
core.bare=false
core.logallrefupdates=true
core.ignorecase=true
core.precomposeunicode=true
remote.origin.url=https://github.com/philemonnwanne/altschool-cloud-exercises.git
remote.origin.fetch=+refs/heads/*:refs/remotes/origin/*
branch.main.remote=origin
branch.main.merge=refs/heads/main
```

## Output of git remote -v

```python
origin	https://github.com/philemonnwanne/altschool-cloud-exercises.git (fetch)
origin	https://github.com/philemonnwanne/altschool-cloud-exercises.git (push)
```

## Output of git log

```php
commit 77fbc27a512b3dcf867ac2c44cdaf94683fd9d41
Author: Philemon Nwanne <108567784+philemonnwanne@users.noreply.github.com>
Date:   Thu Aug 25 16:07:22 2022 +0100

    Update Exercise-03.md

commit be214adf84e19a7123b09a4f11e9ed435084c5a3
Author: Philemon Nwanne <108567784+philemonnwanne@users.noreply.github.com>
Date:   Thu Aug 25 15:03:28 2022 +0100

    Update Exercise-04.md

commit 9aca4dbd7c933b3d86e64767fa0b22e3deb420ad
Author: Philemon Nwanne <108567784+philemonnwanne@users.noreply.github.com>
Date:   Thu Aug 25 14:56:33 2022 +0100

    Uploaded images and updated exercise-04.md

commit 0f28e3b59887809befb5183bcd220f264a00de92
Author: Philemon Nwanne <108567784+philemonnwanne@users.noreply.github.com>
Date:   Thu Aug 25 05:08:35 2022 +0100

    Update Exercise-03.md

commit 000bd4e7b8b2c3f6b0ba78cfb57e5277e181c269
Author: Philemon Nwanne <108567784+philemonnwanne@users.noreply.github.com>
Date:   Thu Aug 25 05:08:05 2022 +0100

    Update Exercise-03.md

commit ef02932eeb1379f5e3218efab834f965bcc471d7
Author: Philemon Nwanne <108567784+philemonnwanne@users.noreply.github.com>
Date:   Thu Aug 25 04:46:07 2022 +0100

    Update Exercise-03.md
    
    Added 22.26,23.46,24.14.pngs

commit d45da1dfe5edf374f5878ffa6767ac16ec0ff520
Author: Philemon Nwanne <108567784+philemonnwanne@users.noreply.github.com>
Date:   Thu Aug 25 04:43:38 2022 +0100

    Update Exercise-03.md

commit d4475fa7cc2126418a600fa78f09a1175e720595
Author: Philemon Nwanne <108567784+philemonnwanne@users.noreply.github.com>
Date:   Thu Aug 25 04:41:14 2022 +0100

    Delete j

commit 0382dabbfaaa1515a669692aa12b964e7d2c6648
Author: Philemon Nwanne <108567784+philemonnwanne@users.noreply.github.com>
Date:   Thu Aug 25 04:40:21 2022 +0100

    Update Exercise-03.md

commit a25572f57785f3c2175ed932cb2c087d63ecf837
Author: Philemon Nwanne <108567784+philemonnwanne@users.noreply.github.com>
Date:   Thu Aug 25 04:23:07 2022 +0100

    Update Exercise-02.md
    
    Updated new links

commit 66f4d71deec08f13f5843d6f8c75b9f065a8213c
Author: Philemon Nwanne <108567784+philemonnwanne@users.noreply.github.com>
Date:   Thu Aug 25 04:16:09 2022 +0100

    Add files via upload
    
    Uploaded uniform sized images

commit f0101b88ac4e24c5a5b97970f1f67f27146841f8
Author: Philemon Nwanne <108567784+philemonnwanne@users.noreply.github.com>
Date:   Thu Aug 25 02:47:40 2022 +0000

    Mass upload of exercises

commit 6f63a9b17d00983175f9afdfb9375ef510478f87
Author: Philemon Nwanne <108567784+philemonnwanne@users.noreply.github.com>
Date:   Thu Aug 25 01:44:55 2022 +0000

    Mod mod mod

commit 1c3c300bf93aa9166b048994b008ec3579a647a7
Author: Philemon Nwanne <108567784+philemonnwanne@users.noreply.github.com>
Date:   Thu Aug 25 02:23:44 2022 +0100

    Create g

commit 4533c0e95c4567eb0fbfe3766a964099f4cb25ee
Author: Philemon Nwanne <108567784+philemonnwanne@users.noreply.github.com>
Date:   Thu Aug 25 01:26:07 2022 +0100

    Update Exercise-03.md

commit 3878f6a487a2b1b956cc6f23ad1cf976f2d40a0e
Author: Philemon Nwanne <108567784+philemonnwanne@users.noreply.github.com>
Date:   Thu Aug 25 01:22:57 2022 +0100

    moved all exercise 3 files up one folder

commit bf6caa1e680ba7a2c8960e2e86978b6041767766
Author: Philemon Nwanne <108567784+philemonnwanne@users.noreply.github.com>
Date:   Thu Aug 25 01:09:53 2022 +0100

    Create d

commit fc63578b7cf9e5de581f5e5deced7b9360dc2084
Author: Philemon Nwanne <108567784+philemonnwanne@users.noreply.github.com>
Date:   Thu Aug 25 01:08:58 2022 +0100

    Create Exercise-01.md

commit a99b933ad6eb22565e5e0c3769d08fbf9528e8b9
Author: Philemon Nwanne <108567784+philemonnwanne@users.noreply.github.com>
Date:   Thu Aug 25 00:59:52 2022 +0100

    Update Exercise-03.md

commit 6a9a64a0c6c12ab591935696ec9dc38c032692b6
Author: Philemon Nwanne <108567784+philemonnwanne@users.noreply.github.com>
Date:   Thu Aug 25 00:54:51 2022 +0100

    Add files via upload

commit 81f6292ec6de7089c5ff5353eacf01b4cbae0862
Author: Philemon Nwanne <108567784+philemonnwanne@users.noreply.github.com>
Date:   Thu Aug 25 00:46:35 2022 +0100

    Add files via upload
    
    Added images for month-01 week-04

commit 51ff670b05bc0f299fd2fbbd48bf4add7147fb0d
Author: Philemon Nwanne <108567784+philemonnwanne@users.noreply.github.com>
Date:   Thu Aug 25 00:43:18 2022 +0100

    Create j

commit 7b60453c44cd75ca60b02d827eb6a38a28cf1c2c
Author: Philemon Nwanne <108567784+philemonnwanne@users.noreply.github.com>
Date:   Thu Aug 25 00:41:45 2022 +0100

    Update README.md
    
    Added altschool logo

commit 8fbc6909608be563184e13b28321beab6712dfe1
Author: Philemon Nwanne <108567784+philemonnwanne@users.noreply.github.com>
Date:   Thu Aug 25 00:39:31 2022 +0100

    Create Exercise-03.md

commit cb2a856538ca87da0049232bc5fad60b596e1a29
Author: Philemon Nwanne <108567784+philemonnwanne@users.noreply.github.com>
Date:   Thu Aug 25 00:38:19 2022 +0100

    Delete Exercise-01.md

commit d6a9918cb62f1994e97f4cf6fe3d25d745375479
Author: Philemon Nwanne <108567784+philemonnwanne@users.noreply.github.com>
Date:   Thu Aug 25 00:37:47 2022 +0100

    Create Exercise-02.md

commit b3a28a6e3641cdbf2b5c1cc3e9bcfd750bc023b3
Author: Philemon Nwanne <108567784+philemonnwanne@users.noreply.github.com>
Date:   Thu Aug 25 00:36:25 2022 +0100

    Created exercise-01

commit 4babbee222f0a32dbb819301135f56995163720a
Author: Philemon Nwanne <108567784+philemonnwanne@users.noreply.github.com>
Date:   Thu Aug 25 00:31:55 2022 +0100

    Initial commit

```
