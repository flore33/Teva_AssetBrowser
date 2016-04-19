

/*
write different level
level1 go to inside directory
level2 select scene to load
or level2 go back to dirctory and select an other directory

*/

-- start at level 1 show list of directories
_level=1
_Directory=@"E:\Teva_AssetBrowser\*"
-- array of items in the directory
_AssetTopItems=getdirectories _Directory

-- array of names of directories in selected directory to show in the UI
_AssetItemsUI=#()

-- array of full directory paths
_AssetItems=#()

for i=1 to _AssetTopItems.count do
	
(
	_AssetItemsUI[i]=(filterstring _AssetTopItems[i] @"\")[3]
)


rollout _AssetBrowser "Asset Browser"

(
	
	listbox _AssetList "Asset List" items:_AssetItemsUI
	button _go "go"
	button _in "in"
	button _up "up"
	
	/*
		if we're at level 1 then show the directories inside the selection
	*/
	on _in pressed do
		
	(
	  if _level==1 do 
		  (
			 _level=2 
			
			  _FXTopDir=_AssetTopItems[_AssetList.selection] + "*"
			
			  --print _FXTopDir
			  
				-- clear the contents of the list ui
				for i=1 to _AssetList.items.count do
				(
					_AssetList.items = deleteItem _AssetList.items 1
				)
				
				-- get the contents of the selected directory FXTopDir
				_AssetItems=getdirectories _FXTopDir 
				_AssetItemsUI=#()
				
				for i=1 to _AssetItems.count do
					
				(
					_temp=(filterstring _AssetItems[i] @"\")[4]
					--print i
					--print _temp
					insertItem _temp _AssetItemsUI i
				)

				/*
					Update the list with _AssetItemsUI
				*/
				_AssetList.items = _AssetItemsUI

		  )
		
	)
	
	/*
	if we're at level 2 then go back to level 1 and show the directories
	*/
	on _up pressed do
	(
		if _level == 2 do
		(
			_level = 1
			-- clear the contents of the list ui
			for i=1 to _AssetList.items.count do
			(
				_AssetList.items = deleteItem _AssetList.items 1
			)
				
			-- show level 1
			--_Directory=@"E:\Teva_AssetBrowser\*"
			_AssetTopItems=getdirectories _Directory

			_AssetItemsUI=#()

			for i=1 to _AssetTopItems.count do
				
			(
				_temp=(filterstring _AssetTopItems[i] @"\")[3]
				--print i
				--print _temp
				insertItem _temp _AssetItemsUI i
			)
			
		--	print "_temp_array"
		--	print _temp_array
			
			/*
				Update the list with _AssetItemsUI
			*/
			_AssetList.items = _AssetItemsUI


		)
	)
	
	/*
	if we're at level 2 then load the selected scene
	*/
	  on _go pressed do
		  
	  (
		  if _level==2 do
		  (
			 -- print "_FXSelectedDir"
			 -- print _FXSelectedDir
			 -- print(_AssetItems[_AssetList.selection])
			  
			  FXAssetDir=_AssetItems[_AssetList.selection]
			  FXAssetMarkerFile=_AssetItemsUI[_AssetList.selection]+"_Marker.ms"
			  print(FXAssetDir+FXAssetMarkerFile)
			  ::filein(FXAssetDir+FXAssetMarkerFile)
		  )
	  )
	
)
createdialog _AssetBrowser
