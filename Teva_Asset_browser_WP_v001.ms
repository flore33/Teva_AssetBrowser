


/*
--hwhn double click on item reveal item in folder

*/


_AssetItems=getdirectories @"\\LONSTUDIONAS01\Studio\Archive\3D Animation Projects\2016\2025623_Teva_Webcast_Proposal\05_Assets\3d & Motion assets\3D Assets\*"
_AssetItemsUI=#()

		for i=1 to _AssetItems.count do
		(
			
		_AssetItemsUI[i]=(filterstring _AssetItems[i] @"\")[10]


		)
rollout _AssetBrowser "Asset Browser"
	(
	
	subrollout Template_graph1  "Template_graph1"
    subrollout test2  "test2"
	)	
		rollout Template_graph "Template_graph"
    (
       spinner test1as "test1as"
    )
	
		rollout test2A "test2A"
    (
       spinner test2as "test2as"
    )


		
		
		--on  _AssetList doubleClicked itm do
--(
 -- print (itm)
	
--)
		
	--button _go "go"
		--on _go pressed do
		--(
		
			--AssetDirectory=_AssetItems[_AssetList.selection]
			--AssetMarker=_AssetItemsUI[_AssetList.selection]+"_Marker.ms"
			--print (AssetDirectory+AssetMarker)
			--::filein (AssetDirectory+AssetMarker)
			
		--DestroyDialog _AssetBrowser
	--	)
	
	

createdialog _AssetBrowser
AddSubRollout _AssetBrowser.Template_graph1 Template_graph
AddSubRollout _AssetBrowser.test2 test2A
_AssetBrowser.Template_graph1.height+=150
_AssetBrowser.test2 test2A.height+=[0,150]