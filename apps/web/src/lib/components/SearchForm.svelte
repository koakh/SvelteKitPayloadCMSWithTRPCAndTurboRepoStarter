<script lang="ts">
  // import { page } from "$app/stores";
  // const s = $page.url.searchParams.get("s") || "";

  const required = false;

  // $: console.log(`form: [${JSON.stringify(form, undefined, 2)}]`);
</script>

<form method="get" action="?/search" preve>
  <input
    class="text-black px-2 py-1 rounded-md mb-2"
    type="input"
    name="s"
    placeholder="search"
    {required}
  />
  <button
    class="px-4 py-1 mx-1 rounded-md text-white transform bg-orange-500 hover:bg-orange-400 focus:outline-nonefocus:bg-orange-400"
    type="submit">Search</button
  >
</form>
