#!/usr/bin/env python

import os
import sys
import re
import argparse
import mwclient


# def get_topic(url):
#     """Extract wiki topic from wiki page URL.

#     :arg str url: Wiki page URL.
#     """
#     anchor = 'index.php/'
#     try:
#         return url[url.index(anchor) + len(anchor):]
#     except ValueError:
#         sys.exit('%s: Failed to extract topic from URL' % url)


def get_replacement(fname):
    """Read in wiki page content replacement.

    :arg str fname: Name of the file with replacement content.
    """
    with open(fname, 'r') as f:
        stuff = f.read()

    # Remove any leading or trailing newlines...
    stuff = stuff.strip('\n')

    return stuff


def replace(page, new_stuff, idx):
    """Replace a part of page's content with ``new_stuff``.

    :arg mwclient.Page page: Wiki page handle.
    :arg str new_stuff: Replacement text.
    :arg str idx: Replacement content's id.
    """
    # Replacement regexp...
    what = r'<div\s+id="%s".*?</div>' % idx
    rpl = re.compile(what, flags=re.DOTALL)

    # Get page text...
    text = page.text()

    # Replace content...
    new_text, num = rpl.subn(new_stuff, text)
    if num == 0:
        sys.exit('%s: Not found to replace' % what)

    # Update page...
    page.save(new_text, summary='<div id="%s"> updated' % idx)


# Command line arguments and options...
desc = 'Replace content inside a <div> on an ESIP wiki page.'
eplg = u'Copyright \u00A9 2015, The HDF Group'
parser = argparse.ArgumentParser(description=desc, epilog=eplg)
parser.add_argument('topic', help='ESIP wiki topic')
parser.add_argument('rpl_file', help='A file with replacement content')
parser.add_argument('-v', '--verbose', help='Explain what is done',
                    action='store_true')
args = parser.parse_args()

# Read in the replacement table content and check its id...
new_table = get_replacement(args.rpl_file)
try:
    idx = re.search('\A\s*<div\s+id="([^"]+)"', new_table).group(1)
except AttributeError:
    sys.exit('Failed to extract div id from %s' % args.rpl_file)
idx_fname = os.path.basename(args.rpl_file).split('.txt')[0]
if idx != idx_fname:
    sys.exit('<div> id from content ("%s") and file name ("%s") not the same'
             % (idx, idx_fname))

# Get the wiki topic from the input URL...
topic = args.topic

if args.verbose:
    sys.stdout.write(
        'Replacing <div id="%s"> on page %s with content from file %s ... '
        % (idx, args.topic, args.rpl_file))
    sys.stdout.flush()

# Log in to ESIP wiki...
wiki = mwclient.Site('wiki.esipfed.org', path='/')
wiki.login('Hdfscript', 'knethdijTyb7')

# Grab the wiki page's handle...
page = wiki.Pages[topic]
if not page.can('edit'):
    sys.exit('%s: Cannot edit this page' % args.topic)

# Replace the page's content...
replace(page, new_table, idx)
if args.verbose:
    sys.stdout.write('done!\n')
