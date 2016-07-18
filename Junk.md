|Category|Metric|Comments
|Response time |< 100ms – Overall response to TSYS (round trip)|Rules, Card Controls and other components all must fit within overall response time
||< 70ms – Scoring + decision|
||< 15ms – Model scoring|
|Data currency|TBD:|Some features use calendar day, others are rolling 24 hours
||< 5sec – Velocity features including intraday auths|Will be informed by data requirements
||< 2hrs – Velocity features excluding intraday auths (e.g. 2:00 AM day after auth)|
|Availability / Recovery|99.99% uptime (based on # transactions)|0.01% downtime includes both planned and unplanned; assumes cost of higher availability > fraud losses during downtime
|||Automatic failover / node recovery
|Capacity|1000 authorizations per second, |Sized for 2x of: current peak day (14MM), peak hour takes 200% of hourly average; +300 TPS padding; no growth (assumes future AWS scaling)
||sustainable for 6 hours|700 TPS = 2 x ((14MM trans / 86.4K secs) * 200%)
||Second metric (TBD):|
||x TPS for  x hours|
|Accuracy|Exactly 1 response for each auth request|
|Extensibility|n/a|Ability to add additional independent components within the overall framework
|Open source|n/a|Leverage open source technologies whenever possible
|Cloud|n/a|Leverage cloud-based computing services
|Scalability|n/a|Ability to horizontally scale all components (cloud automatically) to improve performance
|Operability|n/a|Ability to get real-time performance metrics about the health of the system and the performance of the model
|Maintainability|n/a|Ability to introduce new models, features and data, and ability to modify rules without taking system down (“hot swap”)
|Vendor viability|n/a|Vendor remains viable, contracts include penalties for exiting the contract (including ceasing operations)
