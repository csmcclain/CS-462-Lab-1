ruleset test.twilio.api {
    meta {
        use module twilio.api alias api
            with
                accountSid = meta:rulesetConfig{"accountSid"}
                authToken = meta:rulesetConfig{"authToken"}
        shares messages
    }

    global {
        messages = function(receiver, sender, pageSize) {
            api:messages(receiver, sender, pageSize)
        }
    }

    rule sendSMSMessage {
        select when echo sendSMSMessage
        pre {
            receiver = event:attrs{"To"}
            sender = event:attrs{"From"}
            msg = event:attrs{"Message"}
        }

        api:sendSMS(receiver, sender, msg) setting(response)
    }
}