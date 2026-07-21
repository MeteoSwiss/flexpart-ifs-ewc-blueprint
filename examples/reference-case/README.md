# Reference case

This directory must contain one small, scientifically approved end-to-end test exercising:

1. IFS data access or retrieval from a prepared test bucket.
2. Preflexpart preprocessing.
3. FLEXPART-IFS execution.
4. Pyflexplot plot generation.
5. Output and log publication.

Complete `run.yml` and `expected-outputs.yml` only after agreeing on the test dates, release location, species, runtime, data permissions and expected outputs.

The reference case must avoid restricted or personal data and should be small enough for routine deployment testing.
