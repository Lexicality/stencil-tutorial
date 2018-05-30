# Lex's Stencil Tutorial

While working out how to use the stencil buffer in [Garry's Mod][gmod] I had
to read a lot of tutorials and then mangle a whole bunch of code to get a
proper idea on what things were actually doing.

This repository is an attempt to distill all that knowledge into a series of
documented runnable examples that I hope will help people, and enrich the
sadly unfilled [Garry's Mod Wiki][wiki].

The examples will make great use of the entity `sent_stencil_test` which is
just a prop that doesn't draw itself by default. You could easily substitute
it for any other entity of your own.

It is under the category "Dev Stuff" in the Sandbox spawn menu. If you spawn
one but lose it, run `stencil_tutorial_draw_ents 1` in console and it will
start rendering. Run `stencil_tutorial_draw_ents 0` to hide it again.

When running an example, use `lua_openscript_cl`, for example

    ] lua_openscript_cl stencil_tutorial/basic_clipping.lua

Each example will override the previous, so you can just run them
sequentially. To end an example, run the console command
`stencil_tutorial_end_example`.

[gmod]: https://gmod.facepunch.com/
[wiki]: https://wiki.garrysmod.com/
