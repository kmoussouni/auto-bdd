# Architecture Diagrams

This folder contains PNG diagrams illustrating the Auto-BDD system architecture.

## Diagrams

### docker-stack.png
Shows the Docker Compose stack with all services and their connections:
- nginx (web server)
- PHP (Symfony application)
- PostgreSQL (database)
- Ollama (AI model server)
- Chrome (browserless for testing)

### auto-healing-workflow.png
Illustrates the complete auto-healing BDD loop workflow:
- Test execution
- Failure detection
- Context collection
- AI patch generation
- Patch validation and application
- Test re-run

### request-flow.png
Sequence diagram showing:
- Normal HTTP request flow through the stack
- Auto-healing test flow with AI intervention

## Source

These diagrams are also embedded as Mermaid code in `CLAUDE.md` for easy viewing on GitHub and in markdown editors that support Mermaid.
