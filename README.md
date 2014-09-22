# xs_maintenance-cookbook

TODO: Enter the cookbook description here.

## Supported Platforms

TODO: List your supported platforms.

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['xs_maintenance']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

## Usage

### xs_maintenance::default

Include `xs_maintenance` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[xs_maintenance::default]"
  ]
}
```

## License and Authors

Author:: Todd Pigram (<todd@toddpigram.com>)
