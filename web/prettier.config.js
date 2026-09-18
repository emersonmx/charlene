/**
 * @see https://prettier.io/docs/en/configuration.html
 * @type {import("prettier").Config}
 */
const config = {
    trailingComma: "all",
    semi: true,
    singleQuote: false,
    plugins: ["prettier-plugin-tailwindcss"],
};

export default config;
