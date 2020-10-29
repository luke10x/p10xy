import { parseArgs } from "./parseArgs";

describe('when called with nothing', () => {
    it('creates bad-usage command', () => {
        const command = parseArgs([]);
        expect(command.type).toEqual('bad-usage');
    });
});

describe('when called with --version', () => {
    it('creates version command', () => {
        const command = parseArgs(['--version']);
        expect(command.type).toEqual('version');
    });
});
