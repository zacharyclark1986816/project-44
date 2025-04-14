module StudyGroup::Platform {

    use aptos_framework::coin::{transfer, Coin};
    use aptos_framework::aptos_coin::AptosCoin;
    use aptos_framework::signer;
    use aptos_framework::aptos_account;

    struct StudyGroup has store, key {
        creator: address,
        contribution_reward: u64, // Reward per contribution
    }

    // Function to create a study group with a specific reward for contributions
    public fun create_study_group(account: &signer, reward: u64) {
        let creator_address = signer::address_of(account);
        let group = StudyGroup {
            creator: creator_address,
            contribution_reward: reward,
        };
        move_to(account, group);
    }

    // Function to reward a contributor with tokens for their contribution
    public fun reward_contributor(account: &signer, contributor: address) acquires StudyGroup {
        let group = borrow_global<StudyGroup>(signer::address_of(account));
        transfer<AptosCoin>(account, contributor, group.contribution_reward);
    }
}
