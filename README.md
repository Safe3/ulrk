ulrk
======

User-level rootkit
-----

Your friend leaves their computer unlocked, and you want to play a trick more
subtle than changing their background, sending an email from them, or leaving
Nyan cat playing in their browser window.

If they left a root terminal open, you could easily download any number of
rootkits, or just quickly install ssh and/or add your own key to their
authorized_keys.

But what if there's no root terminal open, and all of the sudo sessions have
expired?

Enter user level rootkit!

First, ulrk will alias the sudo command to a script that looks like sudo, but
steals their password. However, the victim could still see this by running
`alias`. To stop that, we have alias the alias command itself to one that hides
the sudo alias, and the alias alias. Similarly for the `type` and `unalias`
builtins.

There are other ways to detect the rootkit, so we will probably have to alias or
LD_LIBRARY_PATH our way out of most of it.


ulrk assumes the user is using bash, and may not work if they have Fancy
Environments that do Fancy Things(tm) (but then, why are you using bash?).

Still needs to be implemented
----

`type` needs to hide our rootkit aliases (e.g. sudo, alias, type)
`unalias` needs to not work for sudo, but note that the alias script requires
`unalias alias` to work; perhaps use a secret knock generated at runtime to
disable things like alias and unalias (which the unalias alias will need :)

discovery of files: need a way to hide the files of the rootkit, as well as
changes to prexisting files (like ~/.bashrc so it can be persistent). Probably
need to either add our own directory to LD_LIBRARY_PATH and provide our own
rootkit libc to intercept stat/read/(write?) calls



We could `alias unalias`, but then we need some way to allow alias to be
unaliased (so we can call the real alias to add or view existing aliases). We
can disable/enable our unalias alias by running shopt -u/-s expand_aliases, but
so can the user. We could alias shopt, but then we also need some way to disable
THAT when we actually want to remove our P
