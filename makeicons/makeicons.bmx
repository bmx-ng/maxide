
SuperStrict

Framework brl.glmax2d
Import brl.pngloader

Local sizes:Int[] = [24, 48, 64]
Local pixmaps:TPixmap[] = New TPixmap[sizes.length]

For Local i:Int = 0 Until sizes.length
	pixmaps[i] = BuildIcons(sizes[i])
	Select sizes[i]
		Case 24
			SavePixmapPNG pixmaps[i],"../toolbar.png"
		Default
			SavePixmapPNG pixmaps[i],"../toolbar_" + sizes[i] + ".png"
	End Select
Next

Graphics 640,480,0

Local img:TImage[] = New TImage[sizes.length]

For Local i:Int = 0 Until sizes.length
	img[i] = LoadImage(pixmaps[i])
'DrawPixmap p,0,0

	DrawImage img[i],50,100 + i * 80

Next

Flip
WaitKey


Function BuildIcons:TPixmap(sz:Int)

	Local actions:String[] = GetActions()

	Local n:Int = actions.length

	Local p:TPixmap
	
	Local xOffset:Int = 0
	
	For Local i:Int = 0 Until actions.length
		Local t$ = actions[i]
		
		If t<>" "
			Local q:TPixmap=LoadPixmap( sz + "/" + t+".png" )
			If Not p
				Local rgb:Int=0'q.readpixel( 0,0 )
				p=TPixmap.Create( n*sz,sz,PF_RGBA8888 )
				For Local y:Int = 0 Until sz
					For Local x:Int = 0 Until n*sz
						p.WritePixel x,y,rgb
					Next
				Next
			EndIf
			If q.width>sz Or q.height>sz
				q=ResizePixmap( q,sz,sz )
			EndIf
			Local cx:Int = (sz-q.width)/2
			Local cy:Int = (sz-q.height)/2
			p.paste q,xOffset+cx,cy
		EndIf
		xOffset:+sz
	Next
	
	Return p
End Function

Function GetActions:String[]()
	Return [ "New","Open","Close","Save"," ", ..
		 "Cut","Copy","Paste","Find"," ", ..
		 "Build","Build-Run","Step","Step-In","Step-Out","Stop"," ", ..
		 "Home","Back","Forward", ..
		 "Go" ..
		]
End Function
