<script lang="ts">
  import SearchForm from "$lib/components/SearchForm.svelte";
  // props
  export let data;
  // $: console.log(`data: [${JSON.stringify(data, undefined, 2)}]`);
</script>


<div p-8>
  <h1 class="text-2rem">Search</h1>

  <SearchForm />

  {#if data.errors}
    <ul>
      {#each data.errors as error}
        <li>field '{error.field}': {error.message}</li>
      {/each}
    </ul>
  {/if}

  <ul>
    {#each data.products as product}
      <li class="text-gray-400">{product.title}</li>
    {/each}
  </ul>
</div>