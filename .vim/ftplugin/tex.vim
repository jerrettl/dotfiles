imap EDO \documentclass[<++>]{<++>}<CR><++><CR><CR>\begin{document}<CR><++><CR>\end{document}<ESC>5k0<C-j>
imap DOC \documentclass[<++>]{<++>}<CR><++><CR><CR>\begin{document}<CR><++><CR>\end{document}<ESC>5k0<C-j>
imap EFA \begin{frame}<CR><++><CR>\end{frame}<ESC>2k0<C-j>

call IMAP('SUP', '\textsuperscript{<++>}<++>', 'tex')
call IMAP('TNR', '\renewcommand*\rmdefault{ptm}', 'tex')
call IMAP('1IN', '\usepackage[margin=1in]{geometry}', 'tex')
call IMAP('!IN', '\usepackage[margin=1in]{geometry}', 'tex')
call IMAP('DUB', '\usepackage[doublespacing]{setspace}', 'tex')
call IMAP('GOB', '\pagenumbering{gobble}', 'tex')
call IMAP('NUM', '\pagenumbering{arabic}', 'tex')
call IMAP('RES', '\setcounter{enumi}{<++>}', 'tex')

