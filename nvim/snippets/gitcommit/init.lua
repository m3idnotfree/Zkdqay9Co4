local gitcommit_snip = require('util.luasnip.format').gitcommit_snip

local contexts = require 'util.luasnip.context'
local context = contexts.context

local trig = contexts.trig
local dscr = contexts.dscr

return {
  gitcommit_snip(context(trig 'build', dscr 'Changes that affect the build system or external dependencies (example scopes: gulp, broccoli, npm)')),
  gitcommit_snip(context(trig 'ci', dscr 'Changes to our CI configuration files and scripts (example scopes: Travis, Circle, BrowserStack, SauceLabs)')),
  gitcommit_snip(context(trig 'docs', dscr 'Documentation only changes')),
  gitcommit_snip(context(trig 'feat', dscr 'A new feature')),
  gitcommit_snip(context(trig 'fix', dscr 'A bug fix')),
  gitcommit_snip(context(trig 'pref', dscr 'A code change that improves performance')),
  gitcommit_snip(context(trig 'refactor', dscr 'A code change that neither fixes a bug nor adds a feature')),
  gitcommit_snip(context(trig 'style', dscr 'Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)')),
  gitcommit_snip(context(trig 'test', dscr 'Adding missing tests or correcting existing tests')),
  --
  gitcommit_snip(context(trig 'Breaking Changes', dscr 'Breaking Changes')),
  gitcommit_snip(context(trig 'chore', dscr 'Changes to the build process or auxiliary tools and libraries such as documentation generation')),
  gitcommit_snip(context(trig 'improvement', dscr 'improvemet')),

  -- s(
  --   { trig = 'scope' },
  --   c(1, {
  --     t 'animations',
  --     t 'common',
  --     t 'compiler',
  --     t 'compiler-cli',
  --     t 'core',
  --   })
  -- ),
}
