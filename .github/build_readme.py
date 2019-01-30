#!/usr/bin/env python

import xml.etree.ElementTree
import os
import sys

BASEDIR = os.path.dirname(__file__)

HEADER = '''\
# fopina/erDNA Kodi Addon Repository

The following addons are available here:

'''


def process_addon(addon):
    return '- [{name}]({id}/{id}-{version}.zip) {id} v{version}'.format(
        id=addon.get('id'),
        name=addon.get('name'),
        version=addon.get('version'),
    )


def main(args):
    if args:
        BASEDIR = args[0]

    tree = xml.etree.ElementTree.parse(os.path.join(
        BASEDIR,
        'addons.xml'
    ))

    readme = open(os.path.join(BASEDIR, 'README.md'), 'w')

    readme.write(HEADER)
    for addon in tree.getroot():
        if not addon.tag == 'addon':
            continue
        readme.write(process_addon(addon))
        readme.write('\n')


if __name__ == '__main__':
    main(sys.argv[1:])
