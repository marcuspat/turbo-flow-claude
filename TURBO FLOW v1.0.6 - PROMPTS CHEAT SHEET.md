# TURBO FLOW v1.0.6 - PROMPTS CHEAT SHEET

**Copy/paste these prompts into Claude Code**

---

## SETUP

```
Run turbo-init, then source ~/.bashrc, then ruv-init
```

---

## RESEARCH

```
Create a plans/research directory and place an intro.md file with research on [YOUR TOPIC] including key concepts, technical requirements, and reference materials
```

---

## ARCHITECTURE

```
Review /plans/research and create a detailed ADR/DDD implementation using all the various capabilities of Claude Flow: SONA self-learning, Security AIDefence, Hooks, AgentDB memory, ReasoningBank, and other optimizations. Define bounded contexts using DDD principles. Spawn swarm, do NOT implement yet.
```

---

## SPECS (run sk-here and/or os-init first)

```
/speckit.constitution
```

```
/speckit.specify
```

```
/speckit.plan
```

```
/openspec:proposal "[PROJECT NAME]"
```

```
/openspec:validate
```

---

## TRAIN

```
Run cf-train --pattern_type architecture, then cf-patterns list, then cf-pretrain --model-type moe
```

---

## BRANCH

```
Create new branch "[PROJECT NAME]" and commit the architecture files from plans/, .specify/, and openspec/
```

---

## STATUS LINE

```
Update the statusline to match the DDD we just outlined using the ADRs and available hooks and helpers at @claude-flow/security/, @claude-flow/memory/, @claude-flow/hooks/, @claude-flow/neural/, @claude-flow/swarm/, @claude-flow/testing/, @claude-flow/deployment/, @claude-flow/plugins/
```

---

## HELPERS

```
Tell me about the various helpers and what they do at @claude-flow/*, be brief
```

---

## IMPLEMENT (run cf-swarm in another terminal first)

```
Spawn swarm, implement completely, test, validate, benchmark, optimize, document, continue until complete
```

---

## STATUS CHECK

```
What's the status?
```

---

## FIX ISSUES

```
Why is [X] not working? Can you fix it?
```

---

## EXPORT MODEL

```
Tell me how I can export my Claude Flow v3 model and import into another Claude Flow environment
```

---

## PLAYWRIGHT TEST

```
Go create me a Playwright end-to-end test and optimize it. Use 1920x1080 desktop viewport.
```

---

## TESTING

```
Run aqe-generate and aqe-gate for testing, pw-test for E2E tests, sec-audit for security
```

---

## DEPLOY

```
Can you deploy yourself on [PLATFORM]? Here is the API key: [KEY]
```

---

## TOKEN ANALYSIS

```
Go customize the status line, go figure out how much tokens I am using and what are my savings
```

---

## RESEARCH DELEGATION

```
Delegate any questioning or research to Claude Code and point it at the different resources and code sources to find the answer, then point to where it is referencing the answer
```

---

## ASSETS

```
Create folder called assets for screenshots and visual context
```

---

## QUICK COMMANDS

| What | Command |
|------|---------|
| Start Claude | `claude` or `dsp` |
| Init workspace | `turbo-init` |
| Check status | `turbo-status` |
| Help | `turbo-help` |
| RuvVector status | `ruvector-status` |
| Init swarm | `cf-swarm` |
| Generate tests | `aqe-generate` |
| Quality gate | `aqe-gate` |
| Playwright test | `pw-test "description"` |
| Security audit | `sec-audit` |
| Spec-Kit | `sk-here` |
| OpenSpec | `os-init` |

---

## SWARM INIT (anti-drift)

```bash
npx claude-flow@v3alpha swarm init --topology hierarchical --maxAgents 8 --strategy specialized
```

---

## TWO-TERMINAL WORKFLOW

**Terminal 1:** `cf-swarm`

**Terminal 2:** Paste prompts above

---

## FULL WORKFLOW (copy all)

```
1. Run turbo-init && source ~/.bashrc && ruv-init
2. Create plans/research/intro.md with research on [TOPIC]
3. Review /plans/research and create ADR/DDD implementation using Claude Flow capabilities. Spawn swarm, do NOT implement yet.
4. Run sk-here && os-init
5. /speckit.constitution
6. /speckit.specify  
7. /openspec:proposal "[PROJECT]"
8. Run cf-train --pattern_type architecture && cf-pretrain --model-type moe
9. Create branch "[PROJECT]" and commit plans/, .specify/, openspec/
10. In another terminal: cf-swarm
11. Spawn swarm, implement completely, test, validate, benchmark, optimize, document, continue until complete
```

---

**Just ask it. Just do it. RuvVector handles the rest.**
