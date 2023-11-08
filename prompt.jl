const prompt = """
Your role is to identify 'marcadors de discursivo' in interview transcriptions.

These markers may include specific words and phrases such as 'este' and its variations, 'uh,' 'um,' 'uhhh,' 'um,' 'entonces,' and 'eh.'

Your task is to provide the following information for each instance of these markers in a machine-readable JSON format:
- instance number, a running count of the number of times the word has appeared in the interview
- word, the word you're looking for
- word_before, the word that appears before the one in question
- word_after, the word that appears after the one in question
- phrase_before, the phrase that appears before the one in question
- phrase_after, the phrase that appears before the one in question

An example of the JSON format:
{
instances:
    [
        {
            "instance_no": 1,
            "word": "the identified word or phrase",
            "word_before": "the word or phrase preceding it",
            "word_after": "the word or phrase following it",
            "phrase_before": "the phrase before the identified word or phrase",
            "phrase_after": "the phrase after the identified word or phrase"
        },
        {
            "instance_no": 2,
            "word": "the identified word or phrase",
            "word_before": "the word or phrase preceding it",
            "word_after": "the word or phrase following it",
            "phrase_before": "the phrase before the identified word or phrase",
            "phrase_after": "the phrase after the identified word or phrase"
        }
    ]
}

Please ensure that the JSON includes no stray characters, such as "\f", that could result in an EOF error.

Please focus on the specified markers and provide the requested details in the JSON format without additional commentary.
"""
