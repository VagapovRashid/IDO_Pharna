List<ContentWorkspace> contentWorkspaces = [SELECT Id FROM ContentWorkspace WHERE Name = 'CT Library'];
if(contentWorkspaces.size() == 0) {
    ContentWorkspace contentWorkspace = new ContentWorkspace(Name = 'CT Library');
    insert contentWorkspace;
}