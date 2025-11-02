Sphinx Completion Example
=========================

This file demonstrates the Sphinx directive completion feature.

Usage Instructions
------------------

1. Open this file in Vim
2. Type ``.. `` (two periods followed by a space) on a new line
3. Start typing a directive name (e.g., ``cod``)
4. Press ``Ctrl-X Ctrl-O`` to trigger omni-completion
5. Select the desired directive from the completion menu

Examples
--------

.. note::
   This is a note directive. It was completed using the omni-completion!

.. warning::
   This is a warning directive.

.. code-block:: python

   def hello():
       print("Hello, Sphinx!")

.. tip::
   Try typing different prefixes to see all available directives:
   - Type ``.. not`` and complete to see ``note::``
   - Type ``.. cod`` and complete to see ``code-block::`` and ``codeauthor::``
   - Type ``.. `` (just the dots and space) and press Ctrl-X Ctrl-O to see all directives

Available Directives
--------------------

The completion includes 55+ common Sphinx directives, including:

- Admonitions: note, warning, tip, important, caution, danger, error, hint
- Code: code-block, literalinclude, highlight
- Images: image, figure
- Tables: table, csv-table, list-table
- Structure: toctree, contents, sidebar
- Versioning: versionadded, versionchanged, deprecated
- And many more!

Try it yourself below
---------------------

..

.. codeauthor::

