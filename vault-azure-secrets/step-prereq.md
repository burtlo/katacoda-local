To delegate the credential generation task to Vault, you need to give Vault
privileged Azure credentials to perform the task. Refer to the [online Azure
documentation](https://docs.microsoft.com/en-us/azure/active-directory/develop/howto-create-service-principal-portal)
for more details.

1. Launch the [Microsoft Azure Portal](https://portal.azure.com/) and sign in.

1. Select **Azure Active Directory** and select **Properties**.

1. Copy and store the **Directory ID** which is your **tenant ID** for later
   use. ![Tenant ID](vault-autounseal-azure-2.png)

1. Now, select **App registrations**.

1. Select **New registrations**.

1. Enter your desired application name in the **Name** text field, and then
   click **Register**.

1. Copy and store the generated **Application (client) ID** for later use.
   ![Client ID](vault-autounseal-azure-3.png)

1. Select **Certificate & secrets**.

1. Click **New client secret** under the **Client secrets**. When prompted,
   enter some description and then click **Add**. ![Azure
portal](vault-azure-secrets-1.png)

1. Copy and store the generated secret value which is your **client secret**.

1. Click **API permissions** and **Add a permission**.

1. Select **Azure Active Directory Graph** under the **Supported legacy APIs**
   section.

1. Click **Delegated permissions**, expand **User** and then select the
   check-box for **User.Read**.
   ![Azure Active Directory Graph](vault-azure-secrets-3.png)

1. Click **Application permissions**, expand **Application** and
   **Directory**.

1. Select the check-box for **Application.ReadWrite.All** and
   **Directory.ReadWrite.All**.

1. Click **API permissions**.

1. Click **Grant admin consent for azure** to grant the permissions. ![API
permissions](vault-autounseal-azure-4.png)

1. Navigate to the [**Subscriptions** service
   blade](https://portal.azure.com/#blade/Microsoft_Azure_Billing/SubscriptionsBlade).
   Copy and store the **SUBSCRIPTION ID** for later use. ![Subscription
ID](vault-autounseal-azure-1.png)

1. Now, click into your Subscription name.

1. Click **Access control (IAM)** and click **Add** under the **Add a role
   assignment**. ![Access control](vault-azure-secrets-2.png)

1. Select **Owner** under **Role**, and the **Assign Access To** Field should be
   **Azure ID, User Group, or Service Principal**. In the **Select** field, enter
   your application name, or Application (client) ID saved in a previous step to
   discover the application you created.

1. Click **Save**.
