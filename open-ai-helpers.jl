module OpenAIHelpers

using HTTP: request
using JSON3

function get_gpt_chat_completion(messages; model = "gpt-3.5-turbo", temperature = 0.7)
    r = request(
        "POST",
        "https://api.openai.com/v1/chat/completions",
        Dict("Content-Type" => "application/json", "Authorization" => "Bearer $(ENV["OPEN_AI_KEY"])");
        body = """
        {
            "model": "$model",
            "messages": $messages,
            "temperature": $temperature
        }
        """
    )

    b = JSON3.read(String(r.body))

    return b
end

function serialize_message_to_json(system_message, user_message)
    JSON3.write([system_message, user_message])
end

function instances_to_df(resp_b)
    JSON3.read(resp_b[:choices][1][:message][:content])[:instances] |> DataFrame
end

export get_gpt_chat_completion, serialize_message_to_json, instances_to_df
end
