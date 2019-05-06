@echo off
echo Starting lernOS Guide Generation ...

REM Required Software
REM Calibre, includes ebook-convert, https://calibre-ebook.com
REM Ghostscript, https://www.ghostscript.com (version 9.24, version 9.26 does not work!)
REM ImageMagick, https://www.imagemagick.org
REM MiKTeX, https://miktex.org
REM Pandoc, https://pandoc.org
REM Wandmalfarbe Pandoc Template, https://github.com/Wandmalfarbe/pandoc-latex-template

REM Variables
set filename="lernOS-Guide-for-You-en"

REM Delete Old Versions
echo -- Delete old files
del %filename%.docx %filename%.epub %filename%.mobi %filename%.html %filename%.pdf 
rem images\ebook-cover.png
echo -- Old files deleted
REM Create Microsoft Word Version (docx)
echo -- Create Word document
pandoc -s -o %filename%.docx %filename%.md --metadata-file metadata/metadata.yaml
echo -- Word dokument created
REM Create Web Version (html)
echo -- Create HTML dokument
pandoc -s --toc -o %filename%.html %filename%.md --metadata-file metadata/metadata.yaml
echo -- HTML dokument created
REM Create PDF Version (pdf)
echo -- Create PDF dokument
pandoc %filename%.md metadata/metadata.yaml -o %filename%.pdf --from markdown --template lernOS --number-sections -V lang=de-de
echo -- PDF dokument created
REM Create eBook Versions (epub, mobi)
echo -- Create eBook dokuments
magick -density 300 %filename%.pdf[0] images/ebook-cover.png
pandoc -s --epub-cover-image=images/ebook-cover.png -o %filename%.epub %filename%.md
ebook-convert %filename%.epub %filename%.mobi

pause
