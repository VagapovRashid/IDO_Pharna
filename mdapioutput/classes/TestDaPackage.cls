@IsTest
private class TestDaPackage {
    @IsTest
    static void testBehavior() {
        Account newAccount = new Account(Name = 'test');
        insert newAccount;
        List<Account> insertedValues = [SELECT Id FROM Account];
        System.assertEquals(1, insertedValues.size());
    }
}