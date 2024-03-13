import asyncio
import aiohttp
import random 

async def make_request(session, url, payload, headers):
    async with session.post(url, json=payload, headers=headers) as response:
        return await response.text()

async def main(n: int = 100):
    api_url = 'http://localhost:8000/v1/completions'
    headers = {'Authorization': 'Bearer None'}

    async with aiohttp.ClientSession() as session:
        with open('_scratch/prompts.txt', 'r') as file:
            prompts = file.readlines()

        tasks = []
        for _ in range(n):
            # Randomly select a prompt from prompts.txt
            prompt = random.choice(prompts).strip()
            payload = {
                'model': 'mistralai/Mistral-7B-v0.1',
                'prompt': prompt,
                'temperature': 0.0,
                'best_of': 1,
                'max_tokens': random.randint(100, 200),
                # 'stream': True
            }
            tasks.append(make_request(session, api_url, payload, headers))
        responses = await asyncio.gather(*tasks)
        for response in responses:
            print(response)  # Print or process the response

if __name__ == "__main__":
    asyncio.run(main())

