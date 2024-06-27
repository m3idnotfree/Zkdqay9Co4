local tag = require('util.luasnip.format').tag
local single_tag = require('util.luasnip.format').single_tag
local input = require('util.luasnip.format').input
local text = require('util.luasnip.format').text
-- local format = require('util.luasnip.format').format
local labelf = require('util.luasnip.format').labelf

local contexts = require 'util.luasnip.context'
local context = contexts.context
-- local name = contexts.name
local trig = contexts.trig
-- local dscr = contexts.dscr
-- local name_format = trig .. '(..): ..'

return {
  -- format('a:link', 'a href', '<a href="{}"></a>', { 0 }),
  -- s('link_url', {
  --   t '<a href="',
  --   f(function(_, snip)
  --     -- TM_SELECTED_TEXT is a table to account for multiline-selections.
  --     -- In this case only the first line is inserted.
  --     return snip.env.TM_SELECTED_TEXT[1] or {}
  --   end, {}),
  --   t '">',
  --   i(1),
  --   t '</a>',
  --   i(0),
  -- }),
  -- s('transform2', {
  --   i(1, 'initial text'),
  --   t '::',
  --   i(2, 'replacement for e'),
  --   t { '', '' },
  --   -- Lambdas can also apply transforms USING the text of other nodes:
  --   l(l._1:gsub('e', l._2), { 1, 2 }),
  -- }),
  -- s({ trig = 'trafo(%d+)', regTrig = true }, {
  --   -- env-variables and captures can also be used:
  --   l(l.CAPTURE1:gsub('1', l.TM_FILENAME), {}),
  -- }),
  -- s('transform', {
  -- i(1, 'initial text'),
  -- t { '', '' },
  -- lambda nodes accept an l._1,2,3,4,5, which in turn accept any string transformations.
  -- This list will be applied in order to the first node given in the second argument.
  -- l(l._1:match('[^i]*$'):gsub('i', 'o'):gsub(' ', '_'):upper(), 1),
  -- }),
  -- s({ trig = ';a' }, {
  --   t '\\alpha',
  -- }),
  -- s({ trig = ';b', snippetType = 'autosnippet' }, {
  --   t '\\beta',
  -- }),
  -- s({ trig = ';g', snippetType = 'autosnippet' }, {
  --   t '\\gamma',
  -- }),
  text('doctype', '<!DOCTYPE html>'),
  -- main root
  tag(context(trig 'html')),
  -- document metadata
  single_tag(context(trig 'base')),
  tag(context(trig 'head')),
  single_tag(context(trig 'link')),
  single_tag(context(trig 'meta')),
  tag(context(trig 'style')),
  tag(context(trig 'title')),
  -- sectioning root
  tag(context(trig 'body')),
  -- content sectioning
  tag(context(trig 'address')),
  tag(context(trig 'article')),
  tag(context(trig 'aside')),
  tag(context(trig 'footer')),
  tag(context(trig 'header')),
  tag(context(trig 'h1')),
  tag(context(trig 'h2')),
  tag(context(trig 'h3')),
  tag(context(trig 'h4')),
  tag(context(trig 'h5')),
  tag(context(trig 'h6')),
  tag(context(trig 'hgroup')),
  tag(context(trig 'main')),
  tag(context(trig 'nav')),
  tag(context(trig 'section')),
  tag(context(trig 'search')),
  -- text content
  tag(context(trig 'blockquote')),
  tag(context(trig 'dd')),
  tag(context(trig 'div')),
  tag(context(trig 'dl')),
  tag(context(trig 'dt')),
  tag(context(trig 'figcaption')),
  tag(context(trig 'figure')),
  tag(context(trig 'hr')),
  tag(context(trig 'li')),
  tag(context(trig 'menu')),
  tag(context(trig 'ol')),
  tag(context(trig 'p')),
  tag(context(trig 'pre')),
  tag(context(trig 'ul')),
  -- inline text semantics
  tag(context(trig 'a')),
  tag(context(trig 'abbr')),
  tag(context(trig 'b')),
  tag(context(trig 'bdi')),
  tag(context(trig 'bdo')),
  single_tag(context(trig 'br')),
  tag(context(trig 'cite')),
  tag(context(trig 'code')),
  tag(context(trig 'data')),
  tag(context(trig 'dfn')),
  tag(context(trig 'em')),
  tag(context(trig 'i')),
  tag(context(trig 'kbd')),
  tag(context(trig 'mark')),
  tag(context(trig 'q')),
  tag(context(trig 'rp')),
  tag(context(trig 'rt')),
  tag(context(trig 'ruby')),
  tag(context(trig 's')),
  tag(context(trig 'samp')),
  tag(context(trig 'small')),
  tag(context(trig 'span')),
  tag(context(trig 'strong')),
  tag(context(trig 'sub')),
  tag(context(trig 'sup')),
  tag(context(trig 'time')),
  tag(context(trig 'u')),
  tag(context(trig 'var')),
  tag(context(trig 'wbr')),
  -- image and multimedia
  tag(context(trig 'area')),
  tag(context(trig 'audio')),
  tag(context(trig 'img')),
  tag(context(trig 'map')),
  tag(context(trig 'track')),
  tag(context(trig 'video')),
  -- embedded content
  tag(context(trig 'embed')),
  tag(context(trig 'iframe')),
  tag(context(trig 'object')),
  tag(context(trig 'picture')),
  tag(context(trig 'portal')),
  tag(context(trig 'source')),
  -- svg and mathML
  tag(context(trig 'svg')),
  tag(context(trig 'math')),
  -- scripting
  tag(context(trig 'canvas')),
  tag(context(trig 'noscript')),
  tag(context(trig 'script')),
  -- demarcating edits
  tag(context(trig 'del')),
  tag(context(trig 'ins')),
  -- table content
  tag(context(trig 'caption')),
  tag(context(trig 'col')),
  tag(context(trig 'colgroup')),
  tag(context(trig 'table')),
  tag(context(trig 'tbody')),
  tag(context(trig 'td')),
  tag(context(trig 'tfoot')),
  tag(context(trig 'th')),
  tag(context(trig 'thead')),
  tag(context(trig 'tr')),
  -- forms
  tag(context(trig 'button')),
  tag(context(trig 'datalist')),
  tag(context(trig 'fieldset')),
  tag(context(trig 'form')),
  input(),
  input 'checkbox',
  input 'radio',
  -- input_checkbox(),
  -- input_radio(),
  tag(context(trig 'label')),
  tag(context(trig 'legend')),
  tag(context(trig 'meter')),
  tag(context(trig 'optgroup')),
  tag(context(trig 'option')),
  tag(context(trig 'output')),
  tag(context(trig 'progress')),
  tag(context(trig 'select')),
  tag(context(trig 'textarea')),
  -- interactive elements
  tag(context(trig 'details')),
  tag(context(trig 'dialog')),
  tag(context(trig 'summary')),
  -- web components
  tag(context(trig 'slot')),
  tag(context(trig 'template')),
  -- obsolete and deprecated elements

  single_tag(context(trig 'br')),
  labelf(),
}
