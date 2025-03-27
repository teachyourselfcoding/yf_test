# AI Agent support for FI-CA Dispute Case Resolution 

This repository is a fork to https://github.tools.sap/PCP-Joule/pcp-fica-dispute-tran.git

It shall host a Joule content development project to enhance Joule capability for FICA Dispute Management by AI Agentic behaviour.
The project serves as a frontrunner of piloting the features which come with an integration of Joule with Project Agent Builder.

# Joule - Project Agent Builder - Integration in general

*-> todo link adrs, docu, ...* 

# Dispute Resolution Agent 

## Project structure

Enhancing the original `PCP-Joule/pcp-fica-dispute-tran` structure in following way:

```
.
└── fica_dispute_capability
    ├── functions
    │   ├── agent                         -> contains all dialog functions added for agentic scenario  
    │   │   ├── agentTools                   -> fi-ca api access dialog function dirctly called as agent tools
    │   │   ├── helper                       -> a few helper functions
    │   │   ├── util                         -> utility functions used by the agentTools, here expect odata api access
    │   │   └── invoke_dispute_agent.yaml -> dialog function which invokes the agent, called from Joule scenario  
    │   │
    │   ├── disputeCase                   - PCP-Joule original 
    │   └── util                          - PCP-Joule original
    │
    ├── scenarios
    │   ├── ...  
    │   ├── process_dispute_case_agent.yaml       -> scenario definition for agent call, incl. agent source (json) as `agent_config`, handles also human in the loop questions of agent
    │   ├── ...
    │   
    └── tests
        └── features
```

## Deployment 

Subscribe to Joule with a Joule version, which supports the capability schema version '3.13.0-beta'. Subscription process will also provision a tenant of Project Agent Builder.

The capability (named `trans_fica_dispute_agent_capability`) can be deployed into such subaccount using `joule cli`,  

Sample, e.g. with assistant name `dispute_agent` :
```sh
sapdas delete dispute_agent || true && sapdas deploy -c -n dispute_agent
```

Notes: 
- at present time it's recommended to **delete the assistant before redeploy**.

Compile and deploy will:
- deploy the assistant to Joules tenant content repository and 
- install the agent into the Project Agent Builder tenant

The installed agent unique name is build from the **agents source name** (configured in [./scenarios/call_dispute_agent.yaml](./fica_dispute_capability/scenarios/call_dispute_agent.yaml) -> agent_config - "name") **prefixed by an uuid**, which will change at each deployment


## Implementation details

#### API Functions

*... to be documented ...*


#### Invoking an agent

[./functions/agent/invoke_dispute_agent.yaml](./fica_dispute_capability/functions/agent/invoke_dispute_agent.yaml)
```yaml
- actions:
...
  - type: agent-request
    method: POST
    system_alias: APIAGENTCALLBACK
    agent_id: "<? $system_context.systems.get(1).properties.get(0).agent_id ?>"
    path: "<? path ?>"
    headers:
      Content-Type: application/json
    body: <? request_body ?>
    result_variable: "apiResponse"
...
```

The agent will return a structured Json response object. Note the "type" property with the options `answerForUser` and `questionForUser`.

Sample for a `answerForUser`:

```json
{
  "agentResult": {
      "headers": {},
      "body": {
          "agentId": "e85be21b-58d2-40a3-acc3-459ca41f196e",
          "agentMessage": "The current time is 2025-02-20T01:07:20.359Z.",
          "chatId": "1eb94b3b-111e-4140-bb1a-54bbb5541b13",
          "tenantId": "e04c011a-5a17-4303-ac4b-544b5b9866eb",
          "type": "answerForUser",
          "responseHistoryId": "0688c89e-afc3-41ce-b18f-9d9afbfbab59"
      }
  }
}
```

Sample for a `questionForUser` aka "human in the loop response":

```json
{
  "agentResult": {
      "headers": {},
      "body": {
        "agentId": "51b96a95-d3f2-4321-91b9-d7a8a8e2766e",
        "agentMessage": "Approval required",
        "chatId": "dce7c9ac-bc79-4169-b800-c3d405d785c8",
        "missingInputs": [
          {
            "possibleValues": [],
            "name": "approve",
            "description": "The agent wants to execute the closeDisputeCase tool with ```json\n\"{\\\"disputeCaseId\\\":\\\"4444\\\",\\\"creditMemoId\\\":\\\"500500005555\\\"}\"\n```",
            "suggestions": [
              "true",
              "false"
            ],
            "type": "boolean"
          }
        ],
        "tenantId": "e04c011a-5a17-4303-ac4b-544b5b9866eb",
        "type": "questionForUser",
        "responseHistoryId": "98f6f839-cd00-4855-94ef-69cab79fa602"
      }
  }
}
```

</br></br></br>
----

README.md of original PCP-Joule/pcp-fica-dispute-tran  repository:

# FICA Dispute Management

The purpose of this capability is to show details of a dispute case and based on dispute type, provide verification and resolution options to the user. Using resolution steps, the dispute can be processed, credit/payment can be created, credit/payment can be assigned to dispute, and dispute can be closed or rejected, based on user selection. All these are provided as guided options (using buttons) to the user.

Dispute ID is required to trigger the scenario.

Example prompt: show details of dispute 24240

Based on dispute type, below options are shown.

**Missing Credit:**

- Verification options:

  - Review FI-CA open credits
  - Review CI open credits
  - Review closed dispute cases
  - Review Contract Accounts

- Resolution options:
  - Update Contract Account
  - Create FICA credit memo
  - Assign credit memo to dispute
  - Close the dispute
  - Reject the dispute

**Incorrect Credit:**

- Verification options:

  - Review FI-CA open credits
  - Review CI open credits
  - Review closed dispute cases

- Resolution options:
  - Create FICA credit memo
  - Assign credit memo to dispute
  - Close the dispute
  - Reject the dispute

**Missing Payment:**

- Verification options:

  - Review Contract Accounts for Customer
  - Review last 3 months FI-CA invoices
  - Review last 3 months CI invoices

- Resolution options:
  - Create new payment
  - Reset the Clearing
  - Reclarify payment assignment in payment lot
  - Re-assign correct open item
  - Assign payment to dispute
  - Close the dispute
  - Reject the dispute
