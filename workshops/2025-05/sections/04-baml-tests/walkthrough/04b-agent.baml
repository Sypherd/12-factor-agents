class DoneForNow {
  intent "done_for_now"
  message string 
}

function DetermineNextStep(
    thread: string 
) -> CalculatorTools | DoneForNow {
    client "openai/gpt-4o"

    prompt #"
        {{ _.role("system") }}

        You are a helpful assistant that can help with tasks.

        {{ _.role("user") }}

        You are working on the following thread:

        {{ thread }}

        What should the next step be?

        {{ ctx.output_format }}
    "#
}

test HelloWorld {
  functions [DetermineNextStep]
  args {
    thread #"
      {
        "type": "user_input",
        "data": "hello!"
      }
    "#
  }
  @@assert(hello, {{this.intent == "done_for_now"}})
}

test MathOperation {
  functions [DetermineNextStep]
  args {
    thread #"
      {
        "type": "user_input",
        "data": "can you multiply 3 and 4?"
      }
    "#
  }
  @@assert(math_operation, {{this.intent == "multiply"}})
}

