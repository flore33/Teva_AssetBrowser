

/*
write different level
level1 go to inside directory
level2 select scene to load
or level2 go back to dirctory and select an other directory

*/

-- start at level 1 show list of directories
--try(destroyDialog _AssetBrowser) catch()
_level=1
_Directory=@"\\LONSTUDIONAS01\Studio\Archive\3D Animation Projects\2016\2025623_Teva_Webcast_Proposal\05_Assets\3d & Motion assets\3D Assets\*"
_AssetTopItems=getdirectories _Directory

_AssetItemsUI=#()

for i=1 to _AssetTopItems.count do
	
(
	_AssetItemsUI[i]=(filterstring _AssetTopItems[i] @"\")[10]
)


rollout _AssetBrowser "Asset Browser"

(
	
	listbox _AssetList "Asset List" items:_AssetItemsUI
	button _go "go" across:3
	button _in "in"
	button _up "up"
	
	/*
		if we're at level 1 then shpw the directories inside the selection
	*/
	on _in pressed do
		
	(
	  if _level==1 do 
		  (
			 _level=2 
			  FXTopDir=_AssetTopItems[_AssetList.selection] + "*"
			  
			  print FXTopDir
			  
				-- clear the contents of the list ui
				for i=1 to _AssetList.items.count do
				(
					_AssetList.items = deleteItem _AssetList.items 1
				)
				
				-- get the contents of the selected directory FXTopDir
				_AssetItems=getdirectories FXTopDir 
				_AssetItemsUI=#()
				_temp_array=#()
				for i=1 to _AssetItems.count do
					
				(
					_temp=(filterstring _AssetItems[i] @"\")[11]
					--print i
					print _temp
					insertItem _temp _temp_array i
				)
				print "_temp_array"
					print _temp_array
				/*
					Update the list with _AssetItemsUI
				*/
				_AssetList.items = _temp_array
				_AssetItemsUI = _temp_array

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
			_Directory=@"\\LONSTUDIONAS01\Studio\Archive\3D Animation Projects\2016\2025623_Teva_Webcast_Proposal\05_Assets\3d & Motion assets\3D Assets\*"
			_AssetTopItems=getdirectories _Directory

			_AssetItemsUI=#()

			_temp_array=#()
			for i=1 to _AssetTopItems.count do
				
			(
				_temp=(filterstring _AssetTopItems[i] @"\")[10]
				--print i
				--print _temp
				insertItem _temp _temp_array i
			)
			
			--print "_temp_array"
			--print _temp_array
			
			/*
				Update the list with _AssetItemsUI
			*/
			_AssetList.items = _temp_array
			_AssetItemsUI = _temp_array
			


		)
	)
	
	/*
	if we're at level 2 then load the selected scene
	*/
	  on _go pressed do
		  
	  (
		  if _level==2 do
		  (
			  FXTopDir=_AssetTopItems[_AssetList.selection]
			  print  FXTopDir
			  FXAssetMarkerFile=_AssetItemsUI[_AssetList.selection]+"_Marker.ms"
			 -- print(FXAssetDir+FXAssetMarkerFile)
			  --::filein(FXAssetDir+FXAssetMarkerFile)
		  )
	  )
	
)
createdialog _AssetBrowser