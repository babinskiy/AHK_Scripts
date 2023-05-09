#Persistent

SendMode Input
SetWorkingDir, %A_ScriptDir%

OneDirveRootsList := ["C:\Users\Mykola_Babinskyi\OneDrive", "C:\Users\Mykola_Babinskyi\OneDrive - EPAM"]

Period := 120 * 1000

SetTimer, RunSync, %Period%

RunSync:
    For index, OneDriveRoot in OneDirveRootsList
        ForceSync(OneDriveRoot)
Return

ForceSync(OneDriveRoot) {
    SyncFileName := OneDriveRoot . "\.run_sunc"
    SyncFile := FileOpen(SyncFileName, "w")
    SyncFile.Close()
    Sleep, 300
    FileDelete, %SyncFileName%
}
