; John Graham - 2022
; AutoCAD LISP Routine to PDF out a drawing to A1 Landscape and save it to file name from block attributes
(defun c:PDFA1 (/) 

  ; Change "TIT-TXT" to the block name you will be getting data from
  (setq ss (ssget "X" (list (cons 0 "INSERT") (cons 2 "TIT-TXT") (cons 410 (getvar 'ctab)))))

  (setq blk (vlax-ename->vla-object (ssname ss 0)))
  (setq att_list (vlax-invoke blk 'Getattributes))

  ; Change "DWG_NUMBER" to the tag referance that is used for the drawing number in the block
  (foreach att att_list 
    (if (= (vla-get-tagstring att) "DWG_NUMBER") 
      (setq str1 (vla-get-textstring att))
    )
  )

  ; Change "REVISION" to the tag referance that is used for the revision in the block
  (foreach att att_list 
    (if (= (vla-get-tagstring att) "REVISION") 
      (setq str2 (vla-get-textstring att))
    )
  )

  (setq pdfname (strcat (getvar "dwgprefix") str1 " [" str2 "]"))

  ; Change "DWG to PDF.pc3" to your PDF printer of choice
  ; Change "DWG To PDF.pc3" "ISO full bleed A1 (841.00 x 594.00 MM)" to your paper size of choice
  ; Change "acad-TMG.ctb" to your pen configuration
  ; Change options below for various configurations Refer below for more help
  ; https://knowledge.autodesk.com/support/autocad/learn-explore/caas/CloudHelp/cloudhelp/2021/ENU/AutoCAD-Core/files/GUID-625E395D-143A-494F-A1EA-1BF119B927DC-htm.html
  (COMMAND "-PLOT" "Y" "" "DWG To PDF.pc3" "ISO full bleed A1 (841.00 x 594.00 MM)" "m" "L" "N" "e" "f" "c" "Y" "acad-TMG.ctb" "Y" "n" "n" "n" pdfName "N" "y")
  
  (princ)
)