List<ContentWorkspace> contentWorkspaces = [SELECT Id FROM ContentWorkspace WHERE Name = 'Product Logo'];
if(contentWorkspaces.size() == 0) {
    ContentWorkspace contentWorkspace = new ContentWorkspace(Name = 'CT Library');
    insert contentWorkspace;
}