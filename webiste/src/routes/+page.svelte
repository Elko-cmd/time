<script>
  import { onMount } from 'svelte';

  let ntpTime = '';

  onMount(async () => {
    try {
      const response = await fetch('https://time.google.com');
      if (response.ok) {
        const data = await response.json();
        ntpTime = new Date(data.datetime).toLocaleString();
      } else {
        console.error('Failed to fetch NTP time');
      }
    } catch (error) {
      console.error('Error fetching NTP time:', error);
    }
  });
</script>

<main>
  <h1>NTP Time</h1>
  <p>{ntpTime ? ntpTime : 'Loading...'}</p>
</main>

